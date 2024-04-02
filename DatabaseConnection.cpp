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

    QString empTable = "CREATE TABLE Employees("
                                   " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                                   " firstname TEXT NOT NULL,"
                                   " lastname TEXT NOT NULL,"
                                   " username TEXT NOT NULL,"
                                   " password TEXT NOT NULL,"
                                   " email TEXT NOT NULL,"
                                   " phone VARCHAR(10) NOT NULL);";

    if(!query.exec(empTable))
        qDebug()<< "PROBLEM";

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
            QString empValues = "INSERT INTO Employees(firstname, lastname, username, password, email, phone) VALUES (";
            QStringList line = ts.readLine().split(",");

            for(int i = 0; i<line.length(); i++){
                empValues.append("'"+line.at(i));
                empValues.append("',");
            }
            empValues.chop(1);
            empValues.append(");");
            qDebug()<< empValues;
            if(!query.exec(empValues))
                qDebug()<< "PROBLEM";
        }
        f.close();
    }




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
