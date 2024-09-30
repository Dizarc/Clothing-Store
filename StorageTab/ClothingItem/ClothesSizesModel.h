#ifndef CLOTHESSIZESMODEL_H
#define CLOTHESSIZESMODEL_H

#include <QSqlRelationalTableModel>
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
    void filterSizes(int clothingId);
};

#endif // CLOTHESSIZESMODEL_H
