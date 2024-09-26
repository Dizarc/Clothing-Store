#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>

class ClothesModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int filterTypeId READ filterTypeId WRITE setFilterTypeId NOTIFY filterTypeIdChanged);

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

    int filterTypeId() const;
    void setFilterTypeId(int typeId);

signals:
    void filterTypeIdChanged();

public slots:
    bool reassignClothes(const int &oldTypeId, const int &newTypeId);

private:
    int m_filterTypeId = -1;

};

#endif // CLOTHESMODEL_H
