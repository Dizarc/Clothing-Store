#include "Clothing.h"

Clothing::Clothing(QObject *parent) : QSqlRelationalTableModel(parent)
{
    setTable("ClothesTypes");
    setRelation(1, QSqlRelation("Clothes", "typeId", "clothingName"));
    select();
}
