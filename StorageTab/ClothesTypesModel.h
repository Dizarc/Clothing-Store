#ifndef CLOTHESTYPESMODEL_H
#define CLOTHESTYPESMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlTableModel>
#include <QSqlRecord>
#include <QFile>
#include <QUrl>

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
    bool addNewType(const QString &typeName, const QString &typeImageSource);
    bool deleteType(const int &id);
    bool renameType(const int &id, const QString name);
    bool changeTypeImage(const int &id, const QString &typeImageSource);
};

#endif // CLOTHESTYPESMODEL_H
