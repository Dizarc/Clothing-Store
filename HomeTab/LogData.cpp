#include "LogData.h"
#include <QDebug>
LogData::LogData(QObject *parent, QSqlDatabase db) : QObject{parent}
{
    setData();
}

void LogData::setData()
{
    QSqlQuery query("SELECT * FROM ChangeLog");
    query.exec();
    while(query.next()){
        changeLog logEntry;

        logEntry.logId = query.value("logId").toInt();
        logEntry.clothingId = query.value("clothingId").toInt();
        logEntry.clothingId = query.value("typeId").toInt();
        logEntry.sizeId = query.value("sizeId").toInt();
        logEntry.changeDate = query.value("changeDate").toString();
        logEntry.changeCount = query.value("changeCount").toInt();

        m_data.append(logEntry);
    }
}

QLineSeries *LogData::series() const
{
    return m_series;
}

void LogData::addDataPoint(qreal x, qreal y)
{
    m_series->append(x, y);
}

bool LogData::log(const int &cId, const int &tId, const QString &sName, const int &value)
{
    QSqlQuery query("SELECT sizeId FROM Sizes WHERE sizeName = '" + sName + "'");
    query.exec();

    int sizeId;
    if(query.next())
        sizeId = query.value("sizeId").toInt();
    else{
        qWarning()<< "Error on logging count change...";
        return false;
    }

    QSqlTableModel model;

    model.setTable("ChangeLog");

    model.setFilter("clothingId = " + QString::number(cId) + " AND typeId = " + QString::number(tId) + " AND sizeId = " + QString::number(sizeId) +" AND changeDate = '" + QDate::currentDate().toString() + "'");
    model.select();

    QSqlRecord record;
    if(model.rowCount() == 0){
        model.insertRow(model.rowCount() + 1);

        record = model.record(model.rowCount());

        record.setValue("clothingId", cId);
        record.setValue("typeId", tId);
        record.setValue("sizeId", sizeId);
        record.setValue("changeDate", QDate::currentDate().toString());
        record.setValue("changeCount", value);

        model.insertRecord(model.rowCount(), record);
    }else {
        record = model.record(0);
        record.setValue("changeCount", value);

        model.setRecord(0, record);
    }

    return model.submitAll();
}
