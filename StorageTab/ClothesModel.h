#ifndef CLOTHESMODEL_H
#define CLOTHESMODEL_H

#include <QObject>
#include <QSqlRelationalTableModel>

class ClothesModel : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    enum Roles{
        clothingIdRole = Qt::UserRole + 1,
        clothingNameRole,
        typeIdRole
    };

    explicit ClothesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // CLOTHESMODEL_H
