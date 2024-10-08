#ifndef CLOTHESSIZESMODEL_H
#define CLOTHESSIZESMODEL_H

#include <QSqlRelationalTableModel>
#include <QSqlRecord>
#include <QSqlField>
#include <QSqlQuery>
#include <QObject>

class ClothesSizesModel : public QSqlRelationalTableModel
{
    Q_OBJECT

public:
    enum Roles{
        clothingIdRole = Qt::UserRole + 1,
        sizeIdRole,
        countRole
    };
    explicit ClothesSizesModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    void filterClothesSizes(int id);

    bool changeCount(const int &id, const QString &sName, const int &value);
    bool removeClothingSize(const int &id, const int &index);
    bool addSize(const int &id, const int &sId);
};

#endif // CLOTHESSIZESMODEL_H
