#include "ClothesTypesModel.h"

ClothesTypesModel::ClothesTypesModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("ClothesTypes");
    select();
}

QVariant ClothesTypesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case typeIdRole:
        value = row;
        break;
    case typeNameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case typeImageRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> ClothesTypesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[typeIdRole] = "typeId";
    roles[typeNameRole] = "typeName";
    roles[typeImageRole] = "typeImage";

    return roles;
}
