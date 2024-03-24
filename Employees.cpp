#include "Employees.h"

#include <QSqlRecord>

Employees::Employees(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("Employees");
    select();
}

QVariant Employees::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
       return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case idRole:
        value = row;
        break;
    case firstnameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case lastnameRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    case usernameRole:
        value = QSqlTableModel::data(this->index(index.row(), 3));
        break;
    case passwordRole:
        value = QSqlTableModel::data(this->index(index.row(), 4));
        break;
    case emailRole:
        value = QSqlTableModel::data(this->index(index.row(), 5));
        break;
    case phoneRole:
        value = QSqlTableModel::data(this->index(index.row(), 6));
        break;
    default:
        break;
    }

    return value;
}

// bool Employees::setData(const QModelIndex &index, const QVariant &value, int role)
// {

// }

QHash<int, QByteArray> Employees::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[firstnameRole] = "firstname";
    roles[lastnameRole] = "lastname";
    roles[usernameRole] = "username";
    roles[passwordRole] = "password";
    roles[emailRole] = "email";
    roles[phoneRole] = "phone";

    return roles;
}

// int Employees::rowCount(const QModelIndex &parent) const
// {
//     return 2;
// }

// int Employees::columnCount(const QModelIndex &parent) const
// {
//     return 7;
// }

/*
    When user clicks save in EmployeeEdit.qml this function runs
*/
bool Employees::updateEmployee(const int &id, const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{
    this->setTable("Employees");
    this->select();

    QModelIndex firstnameIndex = this->index(id - 1, 1);
    QModelIndex lastnameIndex = this->index(id - 1, 2);
    QModelIndex usernameIndex = this->index(id - 1, 3);
    QModelIndex emailIndex = this->index(id - 1, 5);
    QModelIndex phoneIndex = this->index(id - 1, 6);

    this->setData(firstnameIndex, firstname, Qt::EditRole);
    this->setData(lastnameIndex, lastname, Qt::EditRole);
    this->setData(usernameIndex, username, Qt::EditRole);
    this->setData(emailIndex, email, Qt::EditRole);
    this->setData(phoneIndex, phone, Qt::EditRole);

    emit editedEmployee();

    return this->submitAll();
}

bool Employees::changePasswordEmployee(const int &id, const QString &oldPassword, const QString &newPassword)
{
    QSqlTableModel model;

    model.setTable("Employees");
    model.setFilter("id = "+ QString::number(id) + " AND password = '"+ oldPassword + "'");
    model.select();

    QSqlRecord record = model.record(0);
    record.setValue("password", newPassword);
    model.setRecord(0, record);

    if(!record.isNull("id"))
        emit passwordChanged();

    return model.submitAll();
}

bool Employees::getEmployee(int id)
{
    QSqlTableModel model;

    model.setTable("Employees");
    QString whereStr = "id = '"+ QString::number(id) + "'";

    model.setFilter(whereStr);

    model.select();

}

bool Employees::searchEmployee(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{

    //me to this-> vgainei sthn emfanisi apeuthias opote kapws etsi na to kanw.
    // QSqlRecord record;
    // this->setTable("Employees");
    // this->setFilter("id = " + QString::number(id));

    // this->select();

    // record = this->record(0);
    // record.setValue("firstname", firstname);
    // record.setValue("lastname", lastname);
    // record.setValue("username", username);
    // record.setValue("email", email);
    // record.setValue("phone", phone);

    // this->setRecord(0, record);
    // return this->submitAll();
}
