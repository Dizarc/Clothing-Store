#ifndef EMPLOYEES_H
#define EMPLOYEES_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlTableModel>

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
    //virtual bool setData(const QModelIndex &index, const QVariant &value, int role) override;

    virtual QHash<int, QByteArray> roleNames() const override;
    // virtual int rowCount(const QModelIndex &parent) const override;
    // virtual int columnCount(const QModelIndex &parent) const override;

public slots:
    bool updateEmployee(int id,
                        const QString &firstname,
                        const QString &lastname,
                        const QString &username,
                        const QString &email,
                        const QString &phone);

    bool getEmployee(int id);

    // QAbstractItemModel interface

};
#endif // EMPLOYEES_H
