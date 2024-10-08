#ifndef SIZESMODEL_H
#define SIZESMODEL_H

#include <QObject>
#include <QSqlTableModel>

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
    void filterAvailableSizes(int cId);
};

#endif // SIZESMODEL_H
