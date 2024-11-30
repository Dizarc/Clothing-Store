#include "StorageTab/SizesModel.h"

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

void SizesModel::filterAvailable(int cId)
{
    if(cId == -1)
        setFilter("");
    else
        setFilter("NOT EXISTS "
                  "(SELECT * FROM ClothesSizes WHERE clothingId = " + QString::number(cId) +
                  " AND Sizes.sizeId = ClothesSizes.sizeId)");

    select();
}

bool SizesModel::add(const QString &sizeName)
{
    bool submitting = false;

    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("sizeName", sizeName);

    if(insertRecord(rowCount(), record)){
        select();

        submitting = submitAll();
        if(submitting == false){
            qWarning() << "Error adding clothing item: " << lastError().text();
            revertAll();
        }
    }
    return submitting;
}

bool SizesModel::remove(const int &sId)
{
    bool submitting = false;

    QSqlTableModel clothesSizesModel;

    QString filter = "sizeId = " + QString::number(sId);

    clothesSizesModel.setTable("ClothesSizes");
    clothesSizesModel.setFilter(filter);
    clothesSizesModel.select();

    while(clothesSizesModel.rowCount()){
        clothesSizesModel.removeRow(0);
        clothesSizesModel.select();
    }

    if(!clothesSizesModel.submitAll()){
        qWarning() << "Error removing clothing size(from SizesModel): " << clothesSizesModel.lastError().text();
        clothesSizesModel.revertAll();
    }

    QSqlTableModel sizesModel;

    sizesModel.setTable("Sizes");
    sizesModel.setFilter(filter);
    sizesModel.select();

    if(sizesModel.removeRow(0)){
        select();

        submitting = submitAll();
        if(submitting == false){
            qWarning() << "Error removing size: " << lastError().text();
            revertAll();
        }
    }
    return submitting;
}
