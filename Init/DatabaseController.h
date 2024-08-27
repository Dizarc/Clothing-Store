#ifndef DATABASECONTROLLER_H
#define DATABASECONTROLLER_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QFile>
#include <QIODevice>

#include <bcryptcpp.h>

#include <QSettings>
#include <libraries/SmtpClient-for-Qt/src/SmtpMime>
#include <QUuid>
#include <QCryptographicHash>

class DatabaseController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isEmployeeTableEmpty READ isEmployeeTableEmpty NOTIFY isEmployeeTableEmptyChanged);
    Q_PROPERTY(bool isCurrentlyAdmin READ isCurrentlyAdmin NOTIFY isCurrentlyAdminChanged);


public:
    explicit DatabaseController(QObject *parent = nullptr);
    bool isEmployeeTableEmpty();
    bool isCurrentlyAdmin();

private:
    void createDatabase();

    QString createResetCode(const int &id);

public slots:
    void loginCheck(const QString &username, const QString &password);

    void sendResetEmail(const QString &username);
    void checkResetCode(const QString &username, const QString &code);
    void changePassword(const QString &username, const QString &password);

    bool createAdminUser(const QString firstname, const QString lastname, const QString username, const QString email, const QString phone, const QString password);
signals:
    void isEmployeeTableEmptyChanged();
    void isCurrentlyAdminChanged();
    void wrongLogin();
    void rightLogin();

    void rightPassResetCode();
    void wrongCode();
    void successChangePass();

private:
    bool m_isCurrentlyAdmin;
};

#endif // DATABASECONTROLLER_H
