#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QFile>
#include <QUrl>

#include "Init/DatabaseController.h"

class ClothesModel : public QSqlTableModel
{
    Q_OBJECT

public:
    enum Roles{
        clothingIdRole = Qt::UserRole + 1,
        clothingNameRole,
        clothingDescriptionRole,
        clothingImageSourceRole,
        typeIdRole
    };

    explicit ClothesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool reassignClothes(const int &oldTypeId, const int &newTypeId, const int &clothingId = -1);

    void filterType(int typeId);

    bool rename(const int &cId, const QString name);
    bool changeDescription(const int &cId, const QString description);
    bool changeImage(const int &cId, const QString &ClothingImageSource);
    bool add(const QString &itemName, const QString &itemImageSource, const int &tId);
    bool remove(const int &cId);
};

#endif // CLOTHESMODEL_H
