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

    QString createEmployeesQuery = "CREATE TABLE Employees("
                                   " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                   " firstname TEXT NOT NULL,"
                                   " lastname TEXT NOT NULL,"
                                   " username TEXT NOT NULL,"
                                   " password TEXT NOT NULL,"
                                   " email TEXT NOT NULL,"
                                   " phone VARCHAR(10) NOT NULL);";

    QString addValuesToEmployeesQuery = "INSERT INTO Employees(firstname, lastname, username, password, email, phone) VALUES "
                                        "( "
                                            "\"Root\", "
                                            "\"Admin\", "
                                            "\"root\", "
                                            "\"root\", "
                                            "\"faruk_yildiz@protonmail.com\", "
                                            "'6995613105'), "
                                        "("
                                            "\"Faruk\", "
                                            "\"Yildiz\", "
                                            "\"faruk\", "
                                            "\"faruk12345\", "
                                            "\"faruk_yildiz@hotmail.gr\", "
                                            "'6995613105'"
                                        ");";

    if(!query.exec(createEmployeesQuery))
        qDebug()<< "PROBLEM";

    if(!query.exec(addValuesToEmployeesQuery))
        qDebug()<< "PROBLEM";

    QSqlDatabase::database().commit();

}

QSqlDatabase DatabaseConnection::getDb()
{
    return QSqlDatabase::database();
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

    qDebug()<< "Username: " << username << " password: " << password;
}
