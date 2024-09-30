#include "SizesModel.h"

SizesModel::SizesModel(QObject *parent, QSqlDatabase db) : QSqlTableModel(parent, db)
{
    setTable("Sizes");
    select();
}


QVariant SizesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlTableModel::data(index, role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case sizeIdRole:
        value = row;
        break;
    case sizeNameRole:
        value = QSqlTableModel::data(this->index(index.row(), 1));
        break;
    default:
        break;
    }

    return value;

}

QHash<int, QByteArray> SizesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[sizeIdRole] = "sizeId";
    roles[sizeNameRole] = "sizeName";

    return roles;
}

// void SizesModel::filterNonSizes(int clothingId)
// {
//     setFilter("sizeId = " + QString::number(clothingId));
//     select();
// }
