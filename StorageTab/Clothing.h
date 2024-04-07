#ifndef CLOTHING_H
#define CLOTHING_H

#include <QObject>
#include <QSqlRelationalTableModel>

class Clothing : public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    explicit Clothing(QObject *parent = nullptr);
};

#endif // CLOTHING_H
