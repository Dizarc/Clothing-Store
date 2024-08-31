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
    case typeImageSourceRole:
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
    roles[typeImageSourceRole] = "typeImageSource";

    return roles;
}

bool ClothesTypesModel::addNewType(const QString &typeName, const QString &typeImageSource)
{
    QString localFilePath = QUrl(typeImageSource).toLocalFile();
    QFile image(localFilePath);

    QString newImage = "";
    if(image.exists())
        newImage = DatabaseController::documentsDirPath + "/storage_images/types_images/" + QFileInfo(localFilePath).fileName();

    if(!newImage.isEmpty()){
        if(!image.copy(newImage))
            return false;
    }

    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("typeName", typeName);
    record.setValue("TypeImageSource", newImage);

    if(insertRecord(rowCount(), record)){
        select();
        return submitAll();
    }

    return false;
}
