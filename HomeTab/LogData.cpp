#include "LogData.h"

LogData::LogData(QObject *parent, QSqlDatabase db) : QObject{parent}
{

}

bool LogData::log(const int &cId, const int &tId, const QString &sName, const int &value)
{
    QSqlQuery query;
    query.prepare("SELECT sizeId FROM Sizes WHERE sizeName = ?");
    query.addBindValue(sName);

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

    bool submitting = model.submitAll();
    if(submitting == false){
        qWarning() << "Error logging to ChangeLog: " << model.lastError().text();
        model.revertAll();
    }

    return submitting;
}

QBarSet *LogData::generateSeries(const QString &filter, const int &filterId, const int &sizeId, const QString &dateFilter)
{
    QBarSet* barSet = new QBarSet("Count");

    //SQL date grouping format
    QString dateFormat;
    if(dateFilter == "day")
        dateFormat = "strftime('%Y-%m-%d', changeDate)";
    else if(dateFilter == "month")
        dateFormat = "strftime('%Y-%m', changeDate)";
    else if(dateFilter == "year")
        dateFormat = "strftime('%Y', changeDate)";

    QString queryStr = "SELECT " + dateFormat + " as period, SUM(changeCount) FROM ChangeLog ";

    QStringList whereClause;
    if(sizeId != -1)
        whereClause.append("sizeId = :sizeId");

    if(filter != "all"){
        if(filter == "type")
            whereClause.append("typeId = :typeId");
        else if(filter == "item")
            whereClause.append("clothingId = :clothingId");
    }

    if(!whereClause.isEmpty())
        queryStr += "WHERE " + whereClause.join(" AND ");

    queryStr += " GROUP BY period";

    QSqlQuery query;
    query.prepare(queryStr);

    if(sizeId != -1)
        query.bindValue(":sizeId", sizeId);

    if(filter == "type")
        query.bindValue(":typeId", filterId);
    if(filter == "item")
        query.bindValue(":clothingId", filterId);

    //dates for X axis
    QStringList xDates;
    if(query.exec()){
        while(query.next()){
            QString period = query.value(0).toString();
            int count = query.value(1).toInt();

            xDates.append(period);
            *barSet << count;

            qDebug()<< period << " " << count;
        }
        qDebug()<< "================";
    }else{
        barSet->deleteLater();

        qWarning()<< "Error creating series...";
        return NULL;
    }

    m_categories.clear();
    m_categories.append(xDates);

    emit categoriesChanged();

    return barSet;
}

QStringList LogData::categories() const
{
    return m_categories;
}
