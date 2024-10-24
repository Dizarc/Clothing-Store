#include "DatabaseController.h"

DatabaseController::DatabaseController(QObject *parent)
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

void DatabaseController::createDatabase()
{
    QSqlDatabase::database().transaction();

    QSqlQuery query;

    QString employeesTable = "CREATE TABLE Employees("
                             " id INTEGER PRIMARY KEY AUTOINCREMENT,"
                             " firstname TEXT NOT NULL,"
                             " lastname TEXT NOT NULL,"
                             " username TEXT NOT NULL UNIQUE,"
                             " password TEXT NOT NULL,"
                             " email TEXT NOT NULL,"
                             " phone VARCHAR(10) NOT NULL,"
                             " isAdmin INTEGER DEFAULT 0);";

    if(!query.exec(employeesTable))
        qDebug()<< "Problem while creating employees table...";

    QFile f("DATA.csv");
    if(f.open(QIODevice::ReadOnly)){
        QTextStream ts(&f);

        while(!ts.atEnd()){
            QString employeeValues = "INSERT INTO Employees(firstname, lastname, username, password, email, phone, isAdmin) VALUES (";
            QStringList line = ts.readLine().split(",");

            for(int i = 0; i<line.length(); i++){
                if(i == 3){
                    employeeValues.append("'" + bcryptcpp::generateHash(line.at(i).toStdString()));
                    employeeValues.append("',");
                }else{
                    employeeValues.append("'" + line.at(i));
                    employeeValues.append("',");
                }
            }
            employeeValues.chop(1);
            employeeValues.append(");");
            if(!query.exec(employeeValues))
                qDebug()<< "Problem while adding to Employees table...";
        }
        f.close();
    }
    QSqlDatabase::database().commit();

    QString employeePasswordReset = "CREATE TABLE EmployeePasswordReset("
                                    " id INTEGER,"
                                    " token TEXT NOT NULL,"
                                    " tokenExpiry TEXT NOT NULL,"
                                    "FOREIGN KEY (id) REFERENCES Employees(id));";

    if(!query.exec(employeePasswordReset))
        qDebug()<< "Problem while creating EmployeePasswordReset table...";
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
        qDebug()<< "Problem while creating ClothesTypes table...";

    QString clothesTable = "CREATE TABLE Clothes("
                           " clothingId INTEGER PRIMARY KEY AUTOINCREMENT,"
                           " clothingName TEXT NOT NULL,"
                           " typeId INTEGER,"
                           " FOREIGN KEY (typeId) REFERENCES ClothesTypes(typeId));";

    if(!query.exec(clothesTable))
        qDebug()<< "Problem while creating clothesTable table...";

    QString sizesTable = "CREATE TABLE Sizes("
                         " sizeId INTEGER PRIMARY KEY AUTOINCREMENT,"
                         " sizeName TEXT NOT NULL);";

    if(!query.exec(sizesTable))
        qDebug()<< "Problem while creating Sizes table...";

    QString clothesSizesTable = "CREATE TABLE ClothesSizes("
                                " clothingId INTEGER,"
                                " sizeId INTEGER,"
                                " PRIMARY KEY (clothingId, sizeId),"
                                " FOREIGN KEY (clothingId) REFERENCES Clothes(clothingId),"
                                " FOREIGN KEY (sizeId) REFERENCES sizes(sizeId));";

    if(!query.exec(clothesSizesTable))
        qDebug()<< "Problem while creating ClothesSizes table...";

    QString typesValues = "INSERT INTO ClothesTypes(typeName, typeImage) VALUES"
                          " (\"Pants\", 'INSERT IMAGE HERE'),"
                          " (\"Shoes\", 'INSERT IMAGE HERE');";

    if(!query.exec(typesValues))
        qDebug()<< "Problem while adding to ClothesTypes table...";

    QString sizesValues = "INSERT INTO Sizes(sizeName) VALUES"
                          " (\"Small\"), (\"Medium\"), (\"Large\");";

    if(!query.exec(sizesValues))
        qDebug()<< "Problem while adding to Sizes table...";

    QString clothesValues = "INSERT INTO Clothes(clothingName, typeId) VALUES"
                            " (\"Jeans\", 1),"
                            " (\"Chino Pants\", 1),"
                            " (\"Boots\", 2),"
                            " (\"Sneakers\", 2);";

    if(!query.exec(clothesValues))
        qDebug()<< "Problem while adding to Clothes table...";

    QString clothesSizesValues = "INSERT INTO ClothesSizes(clothingId, sizeId) VALUES"
                                 " (1, 2)," //jeans medium
                                 " (1, 3)," // jeans large
                                 " (2, 2)," // chino medium
                                 " (3, 1)," // boots small
                                 " (4, 1);"; // sneakers small

    if(!query.exec(clothesSizesValues))
        qDebug()<< "Problem while adding to ClothesSizes table...";
}

bool DatabaseController::isEmployeeTableEmpty()
{
    QSqlQuery query("SELECT COUNT(*) FROM Employees");

    if (query.next()) {
        int count = query.value(0).toInt();
        return (count == 0);
    }
    return true;
}

bool DatabaseController::isCurrentlyAdmin(){
    return m_isCurrentlyAdmin;
}

void DatabaseController::setIsCurrentlyAdmin(bool isAdmin){
    if(m_isCurrentlyAdmin != isAdmin){
        m_isCurrentlyAdmin = isAdmin;
        emit isCurrentlyAdminChanged();
    }
}

void DatabaseController::loginCheck(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT password, isAdmin from Employees where username = ?");
    query.addBindValue(username);

    if(!query.exec()){
        qDebug()<< "Problem while getting password, isAdmin from Employees table...";
        return;
    }

    if(query.next()){
        if(bcryptcpp::validatePassword(password.toStdString(), query.value(0).toString().toStdString())){

            setIsCurrentlyAdmin(query.value(1).toBool());

            emit rightLogin();
        }
        else
            emit wrongLogin();
    }
    else
        emit wrongLogin();
}


void DatabaseController::sendResetEmail(const QString &username)
{
    QSqlQuery userQuery;
    userQuery.prepare("SELECT email, firstname, lastname, id from Employees where username = ?");
    userQuery.addBindValue(username);

    if(!userQuery.exec()){
        qDebug()<< "Problem while getting email, firstname, lastname, id from Employees table...";
        return;
    }

    if(!userQuery.next())
        return;

    QString toEmail = userQuery.value(0).toString();
    QString firstname = userQuery.value(1).toString();
    QString lastname = userQuery.value(2).toString();
    int id = userQuery.value(3).toInt();

    //ADD SMTP login credentials from config.ini
    QSettings settings("config.ini", QSettings::IniFormat);
    QString fromEmail = settings.value("email/address").toString();
    QString password = settings.value("email/password").toString();

    MimeMessage message;

    EmailAddress sender(fromEmail, "Clothing Store");

    message.setSender(sender);

    EmailAddress to(toEmail, firstname + " " + lastname);
    message.addRecipient(to);

    QString code = createResetCode(id);
    if(code.isEmpty())
        return;

    message.setSubject("Your Clothing Store password reset");

    MimeText text;

    text.setText("Hi,\n This is the code you requested to reset your account password: " + code + "\n Your code will expire in 10 minutes.");

    message.addPart(&text);

    SmtpClient smtp("smtp.gmail.com", 465, SmtpClient::SslConnection);

    smtp.connectToHost();
    if (!smtp.waitForReadyConnected()) {
        qDebug() << "Failed to connect to host!";
        return;
    }

    smtp.login(fromEmail, password);

    if (!smtp.waitForAuthenticated()) {
        qDebug() << "Failed to login!";
        return;
    }

    smtp.sendMail(message);
    if (!smtp.waitForMailSent()) {
        qDebug() << "Failed to send mail!";
        return;
    }

    smtp.quit();
}

QString DatabaseController::createResetCode(const int &id)
{
    QSqlQuery deleteQuery;
    deleteQuery.prepare("DELETE FROM EmployeePasswordReset");

    if(!deleteQuery.exec()){
        qDebug()<< "Problem while deleting rows from EmployeePasswordReset table...";
        return "";
    }

    QUuid token = QUuid::createUuid();
    QString hashedToken = QCryptographicHash::hash(token.toByteArray(QUuid::Id128), QCryptographicHash::Md5).toBase64();

    QSqlQuery insertQuery;
    insertQuery.prepare("INSERT INTO EmployeePasswordReset (id, token, tokenExpiry) VALUES (?, ?, ?)");
    insertQuery.addBindValue(id);
    insertQuery.addBindValue(hashedToken);
    insertQuery.addBindValue(QDateTime::currentDateTime());

    if(!insertQuery.exec()){
        qDebug()<< "Problem while inserting into EmployeePasswordReset table...";
        return "";
    }

    return hashedToken;
}

void DatabaseController::checkResetCode(const QString &username, const QString &code)
{
    QSqlQuery userQuery;
    userQuery.prepare("SELECT id from Employees where username = ?");
    userQuery.addBindValue(username);

    if(!userQuery.exec()){
        qDebug()<< "Problem while getting id from Employees table...";
        return;
    }

    if(!userQuery.next())
        return;

    QSqlQuery resetQuery;
    resetQuery.prepare("SELECT token, tokenExpiry from EmployeePasswordReset where id = ?");
    resetQuery.addBindValue(userQuery.value(0).toInt());

    if(!resetQuery.exec()){
        qDebug()<< "Problem while getting token, tokenExpiry from EmployeePasswordReset table...";
        return;
    }

    if(!resetQuery.next()){
        emit wrongCode();
        return;
    }

    QString tokenRead = resetQuery.value(0).toString();
    QDateTime dateCreated = resetQuery.value(1).toDateTime();

    if(tokenRead != code){
        emit wrongCode();
        return;
    }

    //if reset code input is more than 10 minutes after creation leave
    if((QDateTime::currentDateTime() - dateCreated) > std::chrono::milliseconds(600000)){
        emit wrongCode();
        return;
    }

    emit rightPassResetCode();
}

void DatabaseController::changePassword(const QString &username, const QString &password)
{
    QSqlQuery userQuery;
    userQuery.prepare("SELECT id from Employees where username = ?");
    userQuery.addBindValue(username);

    if(!userQuery.exec()){
        qDebug()<< "Problem while getting id from Employees table...";
        return;
    }

    if(!userQuery.next())
        return;

    int id = userQuery.value(0).toInt();

    std::string encryptedPassword = bcryptcpp::generateHash(password.toStdString());

    QSqlQuery updateQuery;
    updateQuery.prepare("UPDATE Employees SET password = ? WHERE id = ?");
    updateQuery.addBindValue(QString::fromStdString(encryptedPassword));
    updateQuery.addBindValue(id);

    if(!updateQuery.exec()){
        qDebug()<< "Problem while updating password in Employees table...";
        return;
    }

    emit successChangePass();
}

bool DatabaseController::createAdminUser(const QString firstname, const QString lastname, const QString username, const QString email, const QString phone, const QString password)
{
    QSqlQuery insertQuery;
    insertQuery.prepare("INSERT INTO Employees (firstname, lastname, username, email, phone, password, isAdmin) VALUES (?, ?, ?, ?, ?, ?, ?)");
    insertQuery.addBindValue(firstname);
    insertQuery.addBindValue(lastname);
    insertQuery.addBindValue(username);
    insertQuery.addBindValue(email);
    insertQuery.addBindValue(phone);
    insertQuery.addBindValue(QString::fromStdString(bcryptcpp::generateHash(password.toStdString())));
    insertQuery.addBindValue(1);

    if(!insertQuery.exec()){
        qDebug()<< "Problem while inserting into Employees table...";
        return false;
    }

    emit rightLogin();
    return true;
}
