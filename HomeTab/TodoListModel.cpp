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
    case empIdRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case todoDescriptionRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    case doneRole:
        value = QSqlTableModel::data(this->index(index.row(), 3));
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
    roles[empIdRole] = "empId";
    roles[todoDescriptionRole] = "todoDescription";
    roles[doneRole] = "done";

    return roles;
}
