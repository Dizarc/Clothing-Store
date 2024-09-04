#include "ClothesModel.h"

ClothesModel::ClothesModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("Clothes");
    select();
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
    case typeIdRole:
        value = QSqlTableModel::data(this->index(index.row(), 2));
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

int ClothesModel::filterTypeId() const
{
    return m_filterTypeId;
}

void ClothesModel::setFilterTypeId(int typeId)
{
    if(m_filterTypeId != typeId){
        m_filterTypeId = typeId;
        if(m_filterTypeId == -1)
            setFilter("1 = 0");
        else
            setFilter("typeId = " + QString::number(typeId));

        select();
        emit filterTypeIdChanged();
    }
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
