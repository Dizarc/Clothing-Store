#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>

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

    Q_INVOKABLE void filterType(int typeId);

public slots:
    bool reassignClothes(const int &oldTypeId, const int &newTypeId);

signals:
};

#endif // CLOTHESMODEL_H
