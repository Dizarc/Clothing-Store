#include "ClothesModel.h"

ClothesModel::ClothesModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("Clothes");
}

QVariant ClothesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case clothingIdRole:
        value = row;
        break;
    case clothingNameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    case clothingDescriptionRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
        break;
    case clothingImageSourceRole:
        value = QSqlTableModel::data(this->index(index.row(), 3));
        break;
    case typeIdRole:
        value = QSqlTableModel::data(this->index(index.row(), 4));
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
    roles[clothingDescriptionRole] = "clothingDescription";
    roles[clothingImageSourceRole] = "clothingImageSource";
    roles[typeIdRole] = "typeId";

    return roles;
}

void ClothesModel::filterType(int typeId)
{
    setFilter("typeId = " + QString::number(typeId));
    select();
}

bool ClothesModel::reassignClothes(const int &oldTypeId, const int &newTypeId)
{
    QSqlTableModel model;
    model.setTable("Clothes");
    model.setFilter("typeId = " + QString::number(oldTypeId));
    model.select();

    for(int i = 0; i < model.rowCount(); ++i){
        QSqlRecord record = model.record(i);
        record.setValue("typeId", newTypeId);
        model.setRecord(i, record);
    }

    select();

    return submitAll();
}
