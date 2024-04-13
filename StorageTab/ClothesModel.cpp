#include "ClothesModel.h"

ClothesModel::ClothesModel(QObject *parent, QSqlDatabase db) : QSqlRelationalTableModel(parent, db)
{
    setTable("Clothes");
    setRelation(2, QSqlRelation("ClothesTypes", "typeId", "typeName"));
    select();
}

QVariant ClothesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlRelationalTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlRelationalTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case clothingIdRole:
        value = row;
        break;
    case clothingNameRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 1));
        break;
    case typeIdRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 2));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> ClothesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[clothingIdRole] = "clothingId";
    roles[clothingNameRole] = "clothingName";
    roles[typeIdRole] = "typeId";

    return roles;
}
