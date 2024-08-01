#ifndef DATABASECONNECTION_H
#define DATABASECONNECTION_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QFile>
#include <QIODevice>

class DatabaseConnection : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseConnection(QObject *parent = nullptr);

private:
    void createDatabase();

public slots:
    void loginCheck(const QString &username, const QString &password);

signals:
    void wrongLogin();
    void rightLogin();


};

#endif // DATABASECONNECTION_H
