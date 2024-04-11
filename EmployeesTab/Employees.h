#ifndef EMPLOYEES_H
#define EMPLOYEES_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlTableModel>
#include <QSqlQuery>
#include <QSqlRecord>

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
        phoneRole
    };

    Employees(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    virtual QHash<int, QByteArray> roleNames() const override;    

public slots:
    bool updateEmployee(const int &id,
                        const QString &firstname,
                        const QString &lastname,
                        const QString &username,
                        const QString &email,
                        const QString &phone);

    bool changePasswordEmployee(const int &id,
                                const QString &oldPassword,
                                const QString &newPassword);

    bool deleteEmployee(const int &index);

    bool searchEmployee(const QString &firstname,
                        const QString &lastname,
                        const QString &username,
                        const QString &email,
                        const QString &phone);

    bool addEmployee(const QString &firstname,
                     const QString &lastname,
                     const QString &username,
                     const QString &email,
                     const QString &phone,
                     const QString &password);
signals:
    void passwordChanged();
    void wrongPassword();
    void editedEmployee();
    void deletedEmployee();
    void addedEmployee();
    void notAddedEmployee();
};
#endif // EMPLOYEES_H
