#ifndef LOGDATA_H
#define LOGDATA_H

#include <QLineSeries>
#include <QObject>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlRecord>

class LogData : public QObject
{
    Q_OBJECT
public:
    explicit LogData(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

public slots:
    bool log(const int &cId, const int &tId, const QString &sName, const int &value);
    QLineSeries* generateSeries(const QString &filterType, const int &filterId, const QString& dateFormat);
};

#endif // LOGDATA_H
