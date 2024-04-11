#ifndef CLOTHESTYPESMODEL_H
#define CLOTHESTYPESMODEL_H

#include <QObject>
#include <QSqlTableModel>

class ClothesTypesModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        typeIdRole = Qt::UserRole + 1,
        typeNameRole,
        typeImageRole
    };

    explicit ClothesTypesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

public:
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // CLOTHESTYPESMODEL_H
