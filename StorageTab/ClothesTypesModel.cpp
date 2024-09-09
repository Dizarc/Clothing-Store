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

    if(!newImage.isEmpty())
        image.copy(newImage);

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

bool ClothesTypesModel::deleteType(const int &id)
{
    int uncategorizedId = getUncategorizedTypeId();

    if(uncategorizedId == -1){
        if(!addNewType("uncategorized", "")){
            qWarning()<< "uncategorized type not created!";
            return false;
        }
        uncategorizedId = getUncategorizedTypeId();
    }

    if(id == uncategorizedId){
        qWarning()<< "cannot delete uncategorized type!";
        return false;
    }

    ClothesModel clothes;

    if(!clothes.reassignClothes(id, uncategorizedId)){
        qWarning()<< "could not reassign Clothes!";
        return false;
    }

    QSqlTableModel model;

    model.setTable("ClothesTypes");
    model.setFilter("typeId = "+ QString::number(id));
    model.select();

    model.removeRow(0);

    select();

    return submitAll();

}

bool ClothesTypesModel::renameType(const int &id, const QString name)
{
    int uncategorizedId = getUncategorizedTypeId();

    if(id == uncategorizedId){
        qWarning()<< "cannot change uncategorized types name!";
        return false;
    }

    if((name == "uncategorized") && (uncategorizedId != -1)){
        qWarning()<< "name uncategorized cannot be used!";
        return false;
    }

    QSqlTableModel model;

    model.setTable("ClothesTypes");
    model.setFilter("typeId = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("typeName", name);

    model.setRecord(0, record);

    select();

    return submitAll();
}

bool ClothesTypesModel::changeTypeImage(const int &id, const QString &typeImageSource)
{
    QString localFilePath = QUrl(typeImageSource).toLocalFile();
    QFile image(localFilePath);

    QString newImage = "";
    if(image.exists())
        newImage = DatabaseController::documentsDirPath + "/storage_images/types_images/" + QFileInfo(localFilePath).fileName();

    if(!newImage.isEmpty())
        image.copy(newImage);

    QSqlTableModel model;

    model.setTable("ClothesTypes");
    model.setFilter("typeId = "+ QString::number(id));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("typeImageSource", newImage);

    model.setRecord(0, record);

    select();

    return submitAll();
}

int ClothesTypesModel::getUncategorizedTypeId()
{
    QSqlTableModel model;
    model.setTable("ClothesTypes");

    model.setFilter("typeName = \"uncategorized\"");
    model.select();

    if(model.rowCount() == 0)
        return -1;

    QSqlRecord record = model.record(0);

    return record.value(0).toInt();
}
