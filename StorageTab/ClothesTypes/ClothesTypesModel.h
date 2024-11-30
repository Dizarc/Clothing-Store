#ifndef CLOTHESTYPESMODEL_H
#define CLOTHESTYPESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QFile>
#include <QUrl>

#include "StorageTab/Clothes/ClothesModel.h"
#include "Init/DatabaseController.h"

class ClothesTypesModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        typeIdRole = Qt::UserRole + 1,
        typeNameRole,
        typeImageSourceRole
    };

    explicit ClothesTypesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool add(const QString &typeName, const QString &typeImageSource);
    bool remove(const int &id);
    bool rename(const int &id, const QString name);
    bool changeImage(const int &id, const QString &typeImageSource);

private:
    int getUncategorizedTypeId();
};

#endif // CLOTHESTYPESMODEL_H
