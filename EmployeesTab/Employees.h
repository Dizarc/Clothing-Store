#ifndef EMPLOYEES_H
#define EMPLOYEES_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlTableModel>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlField>
#include <QSqlError>

#include <Bcryptcpp.h>

class Employees : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        idRole = Qt::UserRole + 1,
        firstnameRole,
        lastnameRole,
        usernameRole,
        passwordRole,
        emailRole,
        phoneRole,
        isAdminRole,
    };

    Employees(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;    

public slots:
    bool update(const int &id,
                        const QString &firstname,
                        const QString &lastname,
                        const QString &username,
                        const QString &email,
                        const QString &phone,
                        const int &isAdmin);

    bool changePassword(const int &id,
                                const QString &oldPassword,
                                const QString &newPassword);

    bool remove(const int &index);

    bool search(const QString &firstname,
                        const QString &lastname,
                        const QString &username,
                        const QString &email,
                        const QString &phone,
                        const QVariant &isAdmin);

    bool add(const QString &firstname,
                     const QString &lastname,
                     const QString &username,
                     const QString &email,
                     const QString &phone,
                     const QString &password,
                     const int &isAdmin);
};
#endif // EMPLOYEES_H
