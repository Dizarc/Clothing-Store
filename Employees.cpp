#include "Employees.h"

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

int Employees::rowCount(const QModelIndex &parent) const
{
    return 2;
}

int Employees::columnCount(const QModelIndex &parent) const
{
    return 7;
}

/*
    When user clicks save in EmployeeEdit.qml this function runs
*/
bool Employees::updateEmployee(int id, const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{
    QSqlTableModel model;

    model.setTable("Employees");

    QString whereStr = "id = '"+ QString::number(id) + "'";
    model.setFilter(whereStr);

    model.select();

    QModelIndex firstnameIndex = model.index(0, 1);
    QModelIndex lastnameIndex = model.index(0, 2);
    QModelIndex usernameIndex = model.index(0, 3);
    //password
    QModelIndex emailIndex = model.index(0, 5);
    QModelIndex phoneIndex = model.index(0, 6);

    model.setData(firstnameIndex, firstname, Qt::EditRole);
    model.setData(lastnameIndex, lastname, Qt::EditRole);
    model.setData(usernameIndex, username, Qt::EditRole);
    model.setData(emailIndex, email, Qt::EditRole);
    model.setData(phoneIndex, phone, Qt::EditRole);

    //CHANGES DONT SHOW IN THE DELEGATE
    emit model.dataChanged(firstnameIndex, firstnameIndex);
    emit model.dataChanged(lastnameIndex, lastnameIndex);
    emit model.dataChanged(usernameIndex, lastnameIndex);
    emit model.dataChanged(emailIndex, emailIndex);
    emit model.dataChanged(phoneIndex, phoneIndex);


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
