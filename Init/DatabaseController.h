#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QFile>
#include <QIODevice>

#include <iostream>
#include <string>

#include <bcryptcpp.h>

class DatabaseController : public QObject
{
    Q_OBJECT
public:
    explicit DatabaseController(QObject *parent = nullptr);

private:
    void createDatabase();

public slots:
    void loginCheck(const QString &username, const QString &password);
    void forgotPassword(const QString &username);

signals:
    void wrongLogin();
    void rightLogin();

    void rightPassResetCode();


};

#endif // DATABASECONTROLLER_H
