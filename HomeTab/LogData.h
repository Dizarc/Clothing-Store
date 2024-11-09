#ifndef LOGDATA_H
#define LOGDATA_H

#include <QLineSeries>
#include <QObject>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlRecord>

struct changeLog{
    int logId;
    int clothingId;
    int sizeId;
    QString changeDate;
    int changeCount;
};

class LogData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QLineSeries* series READ series NOTIFY seriesChanged)

public:
    explicit LogData(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    QLineSeries *series() const;

    void addDataPoint(qreal x, qreal y);
public slots:
    bool log(const int &cId, const QString &sName, const int &value);

signals:
    void seriesChanged();

private:
    void setData();

    QList<changeLog> m_data;
    QLineSeries *m_series;
};

#endif // LOGDATA_H
