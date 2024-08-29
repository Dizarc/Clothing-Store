#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlRelationalTableModel>

class ClothesModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(int filterTypeId READ filterTypeId WRITE setFilterTypeId NOTIFY filterTypeIdChanged);
public:
    enum Roles{
        clothingIdRole = Qt::UserRole + 1,
        clothingNameRole,
        typeIdRole
    };

    explicit ClothesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

    int filterTypeId() const;
    void setFilterTypeId(int typeId);

signals:
    void filterTypeIdChanged();

private:
    int m_filterTypeId = -1;

};

#endif // CLOTHESMODEL_H
