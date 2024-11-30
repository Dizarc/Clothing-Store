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

bool ClothesModel::reassignClothes(const int &oldTypeId, const int &newTypeId, const int &clothingId)
{
    QSqlTableModel clothesModel;
    clothesModel.setTable("Clothes");

    //if default value is put into clothingId ( -1) it means that the whole type was deleted
    if(clothingId == -1)
        clothesModel.setFilter("typeId = " + QString::number(oldTypeId));
    else
        clothesModel.setFilter("typeId = " + QString::number(oldTypeId) + " AND clothingId = " + QString::number(clothingId));

    clothesModel.select();

    //change the typeId to the new one in the change log
    QSqlTableModel logModel;
    logModel.setTable("ChangeLog");
    logModel.setFilter("clothingId = " + QString::number(clothingId) + " AND typeId = "+ QString::number(oldTypeId));
    logModel.select();

    for(int i = 0; i < logModel.rowCount(); ++i){
        QSqlRecord logRecord = logModel.record(i);
        logRecord.setValue("typeId", newTypeId);
        logModel.setRecord(i, logRecord);
        if(!logModel.submitAll()){
            qWarning() << "Error while changing type in ChangeLog: " << logModel.lastError().text();
            logModel.revertAll();
        }
    }

    for(int i = 0; i < clothesModel.rowCount(); ++i){
        QSqlRecord clothesRecord = clothesModel.record(i);
        clothesRecord.setValue("typeId", newTypeId);
        clothesModel.setRecord(i, clothesRecord);
    }

    select();

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error reassigning clothes: " << lastError().text();
        revertAll();
    }

    return submitting;
}

void ClothesModel::filterType(int typeId)
{
    setFilter("typeId = " + QString::number(typeId));
    select();
}

bool ClothesModel::rename(const int &cId, const QString name)
{
    QSqlTableModel model;

    model.setTable("Clothes");
    model.setFilter("clothingId = " + QString::number(cId));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("clothingName", name);

    model.setRecord(0, record);

    select();

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error renaming clothing: " << lastError().text();
        revertAll();
    }

    return submitting;
}

bool ClothesModel::changeDescription(const int &cId, const QString description)
{
    QSqlTableModel model;

    model.setTable("Clothes");
    model.setFilter("clothingId = " + QString::number(cId));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("clothingDescription", description);

    model.setRecord(0, record);

    select();

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error changing clothing description: " << lastError().text();
        revertAll();
    }

    return submitting;
}

bool ClothesModel::changeImage(const int &cId, const QString &ClothingImageSource)
{
    QString localFilePath = QUrl(ClothingImageSource).toLocalFile();
    QFile image(localFilePath);

    QString newImage = "";
    if(image.exists())
        newImage = DatabaseController::documentsDirPath + "/storage_images/item_images/" + QFileInfo(localFilePath).fileName();

    if(!newImage.isEmpty())
        image.copy(newImage);

    QSqlTableModel model;

    model.setTable("Clothes");
    model.setFilter("clothingId = " + QString::number(cId));
    model.select();

    QSqlRecord record = model.record(0);

    record.setValue("clothingImageSource", newImage);

    model.setRecord(0, record);

    select();

    bool submitting = submitAll();
    if(submitting == false){
        qWarning() << "Error changing clothing image: " << lastError().text();
        revertAll();
    }

    return submitting;
}

bool ClothesModel::add(const QString &itemName, const QString &itemImageSource, const int &tId)
{
    bool submitting = false;

    QString localFilePath = QUrl(itemImageSource).toLocalFile();
    QFile image(localFilePath);

    QString newImage = "";
    if(image.exists())
        newImage = DatabaseController::documentsDirPath + "/storage_images/item_images/" + QFileInfo(localFilePath).fileName();

    if(!newImage.isEmpty())
        image.copy(newImage);

    insertRow(rowCount() + 1);
    QSqlRecord record = this->record(rowCount());

    record.setValue("clothingName", itemName);
    record.setValue("clothingDescription", "");
    record.setValue("clothingImageSource", newImage);
    record.setValue("typeId", tId);

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

bool ClothesModel::remove(const int &cId)
{
    bool submitting = false;

    QSqlTableModel logModel;

    logModel.setTable("ChangeLog");
    logModel.setFilter("clothingId = " + QString::number(cId));
    logModel.select();

    while(logModel.rowCount()){
        logModel.removeRow(0);
        logModel.select();
    }

    if(!logModel.submitAll()){
        qWarning() << "Error logging removed clothing item: " << logModel.lastError().text();
        logModel.revertAll();
    }

    QSqlTableModel clothesSizesModel;

    QString filter = "clothingId = " + QString::number(cId);

    clothesSizesModel.setTable("ClothesSizes");
    clothesSizesModel.setFilter(filter);
    clothesSizesModel.select();

    while(clothesSizesModel.rowCount()){
        clothesSizesModel.removeRow(0);
        clothesSizesModel.select();
    }

    if(!clothesSizesModel.submitAll()){
        qWarning() << "Error removing clothing item from clothesSizes: " << clothesSizesModel.lastError().text();
        clothesSizesModel.revertAll();
    }

    QSqlTableModel clothesModel;

    clothesModel.setTable("Clothes");
    clothesModel.setFilter(filter);
    clothesModel.select();

    if(clothesModel.removeRow(0)){
        select();

        submitting = submitAll();
        if(submitting == false){
            qWarning() << "Error removing clothing item: " << lastError().text();
            revertAll();
        }
    }
    return submitting;
}
