#ifndef LOGDATA_H
#define LOGDATA_H

#include <QBarSeries>
#include <QBarSet>
#include <QObject>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QBarCategoryAxis>

class LogData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QStringList categories READ categories NOTIFY categoriesChanged)
public:
    explicit LogData(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    QStringList categories() const;

public slots:
    bool log(const int &cId, const int &tId, const QString &sName, const int &value);
    QBarSet* generateSeries(const QString &filterType, const int &filterId, const int &sizeId, const QString& dateFormat);

signals:
    void categoriesChanged();

private:
    QStringList m_categories;
};

#endif // LOGDATA_H
