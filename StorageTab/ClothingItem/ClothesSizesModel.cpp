#include "ClothesSizesModel.h"

ClothesSizesModel::ClothesSizesModel(QObject *parent, QSqlDatabase db) : QSqlRelationalTableModel(parent, db)
{
    setTable("ClothesSizes");
    setRelation(1, QSqlRelation("Sizes", "sizeId", "sizeName"));
}

QVariant ClothesSizesModel::data(const QModelIndex &index, int role) const
{
    if(role < Qt::UserRole){
        return QSqlRelationalTableModel::data(index,role);
    }

    QVariant value;

    QModelIndex primaryKeyIndex = QSqlRelationalTableModel::index(index.row(), 0);

    int row = primaryKeyIndex.data().toInt();

    switch (role) {
    case clothingIdRole:
        value = row;
        break;
    case sizeIdRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 1));
        break;
    case countRole:
        value = QSqlRelationalTableModel::data(this->index(index.row(), 2));
        break;
    default:
        break;
    }

    return value;
}

QHash<int, QByteArray> ClothesSizesModel::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[clothingIdRole] = "clothingId";
    roles[sizeIdRole] = "sizeId";
    roles[countRole] = "count";

    return roles;
}

//selects all sizes on a particular clothing item
void ClothesSizesModel::filterClothesSizes(int cId)
{
    setFilter("clothingId = " + QString::number(cId));
    select();
}

//changes the count for a particular size in a clothing item
bool ClothesSizesModel::changeCount(const int &cId, const QString &sName, const int &value)
{
    QString query = "SELECT * FROM ClothesSizes "
                    "WHERE clothingId = " + QString::number(cId) + " AND ClothesSizes.sizeId = (SELECT sizeId FROM Sizes WHERE sizeName = '" + sName + "')";

    QSqlTableModel model;
    model.setTable("ClothesSizes");
    model.setQuery(query);

    QSqlRecord record = model.record(0);
    // int count = record.field("count").value().toInt();

    record.setValue("count", value);

    model.setRecord(0, record);

    select();

    return submitAll();
}

bool ClothesSizesModel::remove(const int &cId, const int &index)
{
    QSqlTableModel model;

    model.setTable("ClothesSizes");
    model.setFilter("clothingId = " + QString::number(cId));
    model.select();
    model.removeRow(index);

    select();

    return submitAll();
}

//adds new size for the particular clothing item
bool ClothesSizesModel::add(const int &cId, const int &sId)
{
    QSqlTableModel model;

    model.setTable("ClothesSizes");
    model.setFilter("clothingId = " + QString::number(cId) + " AND sizeId = " + QString::number(sId));
    model.select();

    if(model.rowCount() != 0)
        return false;

    model.setFilter("clothingId = " + QString::number(cId));
    model.select();

    model.insertRow(rowCount() + 1);
    QSqlRecord record = model.record(rowCount());

    record.setValue("clothingId", cId);
    record.setValue("sizeId", sId);
    record.setValue("count", 1);

    if(model.insertRecord(rowCount(), record)){
        select();
        return submitAll();
    }

    return false;
}
