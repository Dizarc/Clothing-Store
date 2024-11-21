#include "TodoListModel.h"

TodoListModel::TodoListModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("TodoList");
    select();
}

QVariant TodoListModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case todoIdRole:
        value = row;
        break;
    case todoDescriptionRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case doneRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> TodoListModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[todoIdRole] = "todoId";
    roles[todoDescriptionRole] = "todoDescription";
    roles[doneRole] = "done";

    return roles;
}

bool TodoListModel::remove(const int &index)
{
    removeRow(index);
    select();
    return submitAll();
}

bool TodoListModel::add()
{
    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("todoDescription", "");
    record.setValue("done", 0);

    if(insertRecord(rowCount(), record)){
        select();
        return submitAll();
    }
    return false;
}

bool TodoListModel::changeDescription(const int &index, const QString &description)
{
    QModelIndex descriptionIndex = this->index(index, 1);
    setData(descriptionIndex, description, Qt::EditRole);

    bool submitting = submitAll();
    if(submitting == false)
        revert();

    return submitting;
}

bool TodoListModel::changeDone(const int &index, const int &done)
{
    QModelIndex doneIndex = this->index(index, 2);
    setData(doneIndex, done, Qt::EditRole);

    bool submitting = submitAll();
    if(submitting == false)
        revert();

    return submitting;
}
