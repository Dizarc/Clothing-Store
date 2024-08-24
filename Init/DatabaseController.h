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
public:
    explicit DatabaseController(QObject *parent = nullptr);

private:
    void createDatabase();

    QString createResetCode(const int &id);

public slots:
    void loginCheck(const QString &username, const QString &password);

    void sendResetEmail(const QString &username);
    void checkResetCode(const QString &username, const QString &code);
    void changePassword(const QString &username, const QString &password);

signals:
    void wrongLogin();
    void rightLogin();

    void rightPassResetCode();
    void wrongCode();
    void successChangePass();

};

#endif // DATABASECONTROLLER_H
