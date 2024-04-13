#include "DatabaseConnection.h"

DatabaseConnection::DatabaseConnection(QObject *parent)
    : QObject{parent}
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("localhost");
    db.setDatabaseName("clothes");
    db.setUserName("manager");
    db.setPassword("clothingManager");
    bool ok = db.open();

    if(!ok){
        qDebug() << "Problem occured while connecting to db!";
    }
    if(db.tables().isEmpty()){
        createDatabase();
        qDebug() <<"CREATING";
    }

}

void DatabaseConnection::createDatabase()
{
    QSqlDatabase::database().transaction();

    QSqlQuery query;

    QString employeesTable = "CREATE TABLE Employees("
                             " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                             " firstname TEXT NOT NULL,"
                             " lastname TEXT NOT NULL,"
                             " username TEXT NOT NULL,"
                             " password TEXT NOT NULL,"
                             " email TEXT NOT NULL,"
                             " phone VARCHAR(10) NOT NULL);";
    if(!query.exec(employeesTable))
        qDebug()<< "PROBLEM EMP";

    // QString empValues = "INSERT INTO Employees(firstname, lastname, username, password, email, phone) VALUES "
    //                                     "( "
    //                                         "\"Root\", "
    //                                         "\"Admin\", "
    //                                         "\"root\", "
    //                                         "\"root\", "
    //                                         "\"faruk_yildiz@protonmail.com\", "
    //                                         "'6995613105'); ";

    QFile f("DATA.csv");
    if(f.open(QIODevice::ReadOnly)){
        QTextStream ts(&f);

        while(!ts.atEnd()){
            QString employeeValues = "INSERT INTO Employees(firstname, lastname, username, password, email, phone) VALUES (";
            QStringList line = ts.readLine().split(",");

            for(int i = 0; i<line.length(); i++){
                employeeValues.append("'"+line.at(i));
                employeeValues.append("',");
            }
            employeeValues.chop(1);
            employeeValues.append(");");
            if(!query.exec(employeeValues))
                qDebug()<< "PROBLEM EMP VALUES";
        }
        f.close();
    }
    QSqlDatabase::database().commit();

    /*
        clothesTypes table has types inside it example: Pants, Shoes, Shirts
        Clothes table has each clothing inside it example: Jeans, work boots etc. Each of those has one clothing type.
        sizes table has each size inside it example: small, medium, large
        ClothesSizes table makes it so multiple clothes can be attached to multiple sizes and multiple sizes can be attached to multiple clothes.
    */
    QString clothesTypesTable = "CREATE TABLE ClothesTypes("
                                " typeId INTEGER PRIMARY KEY AUTOINCREMENT,"
                                " typeName TEXT NOT NULL,"
                                " typeImage BLOB);";

    if(!query.exec(clothesTypesTable))
        qDebug()<< "PROBLEM TYPES";

    QString clothesTable = "CREATE TABLE Clothes("
                           " clothingId INTEGER PRIMARY KEY AUTOINCREMENT,"
                           " clothingName TEXT NOT NULL,"
                           " typeId INTEGER,"
                           " FOREIGN KEY (typeId) REFERENCES ClothesTypes(typeId));";

    if(!query.exec(clothesTable))
        qDebug()<< "PROBLEM CLOTHES";

    QString sizesTable = "CREATE TABLE Sizes("
                         " sizeId INTEGER PRIMARY KEY AUTOINCREMENT,"
                         " sizeName TEXT NOT NULL);";

    if(!query.exec(sizesTable))
        qDebug()<< "PROBLEM SIZES";

    QString clothesSizesTable = "CREATE TABLE ClothesSizes("
                                " clothingId INTEGER,"
                                " sizeId INTEGER,"
                                " PRIMARY KEY (clothingId, sizeId),"
                                " FOREIGN KEY (clothingId) REFERENCES Clothes(clothingId),"
                                " FOREIGN KEY (sizeId) REFERENCES sizes(sizeId));";

    if(!query.exec(clothesSizesTable))
        qDebug()<< "PROBLEM CLOTHESSIZES";

    QString typesValues = "INSERT INTO ClothesTypes(typeName, typeImage) VALUES"
                          " (\"Pants\", 'INSERT IMAGE HERE'),"
                          " (\"Shoes\", 'INSERT IMAGE HERE');";

    if(!query.exec(typesValues))
        qDebug()<< "PROBLEM TYPES";

    QString sizesValues = "INSERT INTO Sizes(sizeName) VALUES"
                          " (\"Small\"), (\"Medium\"), (\"Large\");";

    if(!query.exec(sizesValues))
        qDebug()<< "PROBLEM TYPES";

    QString clothesValues = "INSERT INTO Clothes(clothingName, typeId) VALUES"
                            " (\"Jeans\", 1),"
                            " (\"Chino Pants\", 1),"
                            " (\"Boots\", 2),"
                            " (\"Sneakers\", 2);";

    if(!query.exec(clothesValues))
        qDebug()<< "PROBLEM TYPES";

    QString clothesSizesValues = "INSERT INTO ClothesSizes(clothingId, sizeId) VALUES"
                                 " (1, 2)," //jeans medium
                                 " (1, 3)," // jeans large
                                 " (2, 2)," // chino medium
                                 " (3, 1)," // boots small
                                 " (4, 1);"; // sneakers small

    if(!query.exec(clothesSizesValues))
        qDebug()<< "PROBLEM TYPES";
}

void DatabaseConnection::loginCheck(const QString &username, const QString &password)
{
    QSqlDatabase db = QSqlDatabase::database();

    QSqlQuery query;
    query.prepare("SELECT id from Employees where username = ? AND password = ?");
    query.addBindValue(username);
    query.addBindValue(password);

    if(!query.exec())
        qDebug()<< "QUERY PROBLEM";

    if(query.next())
        emit rightLogin();
    else
        emit wrongLogin();
}
