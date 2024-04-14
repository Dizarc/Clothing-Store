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

/*
    updateEmployee and changePasswordEmployee use two different ways to change the data in an sql table.
    updateEmployee uses the index from the delegate
    changePasswordEmployee uses the id from the row.
*/
bool Employees::updateEmployee(const int &index, const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{
    QModelIndex firstnameIndex = this->index(index, 1);
    QModelIndex lastnameIndex = this->index(index, 2);
    QModelIndex usernameIndex = this->index(index, 3);
    QModelIndex emailIndex = this->index(index, 5);
    QModelIndex phoneIndex = this->index(index, 6);

    setData(firstnameIndex, firstname, Qt::EditRole);
    setData(lastnameIndex, lastname, Qt::EditRole);
    setData(usernameIndex, username, Qt::EditRole);
    setData(emailIndex, email, Qt::EditRole);
    setData(phoneIndex, phone, Qt::EditRole);

    emit editedEmployee();

    return submitAll();
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
    else
        emit wrongPassword();

    return model.submitAll();
}

bool Employees::deleteEmployee(const int &index)
{
    removeRow(index);
    select();

    emit deletedEmployee();

    return submitAll();
}

bool Employees::searchEmployee(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone)
{
    setFilter("(firstname LIKE CONCAT('" + firstname + "', '%') OR '" + firstname + "' = '')"
                    + " AND "
                    + "(lastname LIKE CONCAT('" + lastname + "', '%') OR '" + lastname + "' = '')"
                    + " AND "
                    + "(username LIKE CONCAT('" + username + "', '%') OR '" + username + "' = '')"
                    + " AND "
                    + "(email LIKE CONCAT('" + email + "', '%') OR '" + email + "' = '')"
                    + " AND "
                    + "(phone LIKE CONCAT('" + phone + "', '%') OR '" + phone + "' = '')"
                    );
    return select();
}

bool Employees::addEmployee(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone, const QString &password)
{
    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("firstname", firstname);
    record.setValue("lastname", lastname);
    record.setValue("username", username);
    record.setValue("email", email);
    record.setValue("phone", phone);
    record.setValue("password", password);

    if(insertRecord(rowCount(), record))
        emit addedEmployee();
    else
        emit notAddedEmployee();

    select();

    return submitAll();
}
