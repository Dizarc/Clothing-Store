#ifndef SIZESMODEL_H
#define SIZESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>

#include "ClothingItem/ClothesSizesModel.h"

class SizesModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
       sizeIdRole = Qt::UserRole + 1,
        sizeNameRole
    };
    explicit SizesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void filterAvailable(int cId = -1);
    bool add(const QString &sizeName);
    bool remove(const int &sId);
};

#endif // SIZESMODEL_H
