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
    case isAdminRole:
        value = QSqlTableModel::data(this->index(index.row(), 7));
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
    roles[isAdminRole] = "isAdmin";

    return roles;
}

/*
    update and changePassword use two different ways to change the data in an sql table.
    update uses the index from the delegate
    changePassword uses the id from the row.
*/
bool Employees::update(const int &index, const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone, const int &isAdmin)
{
    QModelIndex firstnameIndex = this->index(index, 1);
    QModelIndex lastnameIndex = this->index(index, 2);
    QModelIndex usernameIndex = this->index(index, 3);
    QModelIndex emailIndex = this->index(index, 5);
    QModelIndex phoneIndex = this->index(index, 6);
    QModelIndex isAdminIndex = this->index(index, 7);

    setData(firstnameIndex, firstname, Qt::EditRole);
    setData(lastnameIndex, lastname, Qt::EditRole);
    setData(usernameIndex, username, Qt::EditRole);
    setData(emailIndex, email, Qt::EditRole);
    setData(phoneIndex, phone, Qt::EditRole);
    setData(isAdminIndex, isAdmin, Qt::EditRole);

    bool submitting = submitAll();
    if(submitting == false)
        revert();

    return submitting;
}

bool Employees::changePassword(const int &id, const QString &oldPassword, const QString &newPassword)
{
    QSqlTableModel model;

    model.setTable("Employees");
    model.setFilter("id = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    QString oldHash = record.field("password").value().toString();

    if(bcryptcpp::validatePassword(oldPassword.toStdString(), oldHash.toStdString()))
    {
        QString newHash = QString::fromStdString(bcryptcpp::generateHash(newPassword.toStdString()));
        record.setValue("password", newHash);
        model.setRecord(0, record);

        return model.submitAll();
    }

    return false;
}

bool Employees::remove(const int &index)
{
    removeRow(index);
    select();
    return submitAll();
}

bool Employees::search(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone, const QVariant &isAdmin)
{
    QString filter = "(firstname LIKE CONCAT('" + firstname + "', '%') OR '" + firstname + "' = '')"
                     + " AND "
                     + "(lastname LIKE CONCAT('" + lastname + "', '%') OR '" + lastname + "' = '')"
                     + " AND "
                     + "(username LIKE CONCAT('" + username + "', '%') OR '" + username + "' = '')"
                     + " AND "
                     + "(email LIKE CONCAT('" + email + "', '%') OR '" + email + "' = '')"
                     + " AND "
                     + "(phone LIKE CONCAT('" + phone + "', '%') OR '" + phone + "' = '')";

    if(!isAdmin.isNull())
        filter += " AND (isAdmin = " + QString::number(isAdmin.toBool()) + ")";

    setFilter(filter);

    return select();
}

bool Employees::add(const QString &firstname, const QString &lastname, const QString &username, const QString &email, const QString &phone, const QString &password, const int &isAdmin)
{
    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("firstname", firstname);
    record.setValue("lastname", lastname);
    record.setValue("username", username);
    record.setValue("email", email);
    record.setValue("phone", phone);
    record.setValue("password", QString::fromStdString(bcryptcpp::generateHash(password.toStdString())));
    record.setValue("isAdmin", isAdmin);

    if(insertRecord(rowCount(), record)){
        select();
        return submitAll();
    }

    return false;
}
