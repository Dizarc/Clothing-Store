#include "LogData.h"

LogData::LogData(QObject *parent, QSqlDatabase db) : QObject{parent}
{

}

bool LogData::log(const int &cId, const int &tId, const QString &sName, const int &value)
{
    QSqlQuery query("SELECT sizeId FROM Sizes WHERE sizeName = '" + sName + "'");

    int sizeId;
    if(query.exec()){
        if(query.next())
            sizeId = query.value("sizeId").toInt();
    }else{
        qWarning()<< "Error on logging count change...";
        return false;
    }

    QSqlTableModel model;

    QString currDate = QDate::currentDate().toString("yyyy-MM-dd");

    model.setTable("ChangeLog");

    model.setFilter("clothingId = " + QString::number(cId) + " AND typeId = " + QString::number(tId) + " AND sizeId = " + QString::number(sizeId) +" AND changeDate = '" + currDate + "'");
    model.select();

    QSqlRecord record;
    if(model.rowCount() == 0){
        model.insertRow(model.rowCount() + 1);

        record = model.record(model.rowCount());

        record.setValue("clothingId", cId);
        record.setValue("typeId", tId);
        record.setValue("sizeId", sizeId);
        record.setValue("changeDate", currDate);
        record.setValue("changeCount", value);

        model.insertRecord(model.rowCount(), record);
    }else {
        record = model.record(0);
        record.setValue("changeCount", value);

        model.setRecord(0, record);
    }

    return model.submitAll();
}

QLineSeries *LogData::generateSeries(const QString &filter, const int &filterId, const QString &dateFilter)
{
    QLineSeries *series = new QLineSeries();

    //format format date by day, month, year
    QString dateFormat;
    if(dateFilter == "day")
        dateFormat = "strftime('%Y-%m-%d', changeDate)";
    else if(dateFilter == "month")
        dateFormat = "strftime('%Y-%m', changeDate)";
    else if(dateFilter == "year")
        dateFormat = "strftime('%Y', changeDate)";

    QString queryStr = "SELECT " + dateFormat + " as period, SUM(changeCount) FROM ChangeLog ";

    if(filter == "all")
        queryStr += "GROUP BY period";
    else{
        queryStr += "WHERE %2 = ? GROUP BY period";

        if(filter == "type")
            queryStr = queryStr.arg("typeId");
        else if(filter == "item")
            queryStr = queryStr.arg("clothingId");
        else if(filter == "size")
            queryStr = queryStr.arg("sizeId");
    }

    QSqlQuery query(queryStr);
    query.prepare(queryStr);

    if(filter != "all")
        query.addBindValue(filterId);

    if(query.exec()){
        while(query.next()){
            QString period = query.value(0).toString();
            int count = query.value(1).toInt();

            QDateTime date;
            if(dateFilter == "day")
                date = QDateTime::fromString(period, "yyyy-MM-dd");
            else if(dateFilter == "month")
                date = QDateTime::fromString(period, "yyyy-MM");
            else if(dateFilter == "year")
                date = QDateTime::fromString(period, "yyyy");
            qDebug()<< period<<" "<< count;
            series->append(date.toMSecsSinceEpoch(), count);
        }
        qDebug()<< "================";
    }else{
        qWarning()<< "Error creating series...";
        return series;
    }



    return series;
}
