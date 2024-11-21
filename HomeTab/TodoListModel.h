#ifndef TODOLISTMODEL_H
#define TODOLISTMODEL_H

#include <QObject>
#include <QSqlTableModel>
#include <QSqlRecord>

class TodoListModel : public QSqlTableModel
{
    Q_OBJECT
public:
    enum Roles{
        todoIdRole = Qt::UserRole + 1,
        todoDescriptionRole,
        doneRole
    };
    explicit TodoListModel(QObject *parent = nullptr, QSqlDatabase db = QSqlDatabase());

    virtual QVariant data(const QModelIndex &index, int role) const override;
    virtual QHash<int, QByteArray> roleNames() const override;

public slots:
    bool remove(const int &index);
    bool add();
    bool changeDescription(const int &index, const QString &description);
    bool changeDone(const int &index, const int &done);
};

#endif // TODOLISTMODEL_H
