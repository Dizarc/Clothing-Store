#ifndef TODOLISTMODEL_H
#define TODOLISTMODEL_H

#include <QObject>
#include <QSqlTableModel>

class TodoListModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        todoIdRole = Qt::UserRole + 1,
        empIdRole,
        todoDescriptionRole,
        doneRole
    };
    explicit TodoListModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    // QAbstractItemModel interface
public:
    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;
};

#endif // TODOLISTMODEL_H
