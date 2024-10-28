#include "DatabaseController.h"

const QString DatabaseController::documentsDirPath =
    QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation) + "/ClothingStoreDocuments";

DatabaseController::DatabaseController(QObject *parent)
    : QObject{parent}
{
    QDir documentsDir(documentsDirPath);
    if(!documentsDir.exists()){
        documentsDir.mkpath(".");
        documentsDir.mkpath("./storage_images/types_images");
        documentsDir.mkpath("./storage_images/item_images");
    }

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setHostName("localhost");
    db.setDatabaseName(documentsDirPath + "/clothes");
    db.setUserName("manager");
    db.setPassword("clothingManager");
    bool ok = db.open();

    if(!ok){
        qWarning() << "Problem occured while connecting to db!";
    }
    if(db.tables().isEmpty()){
        createDatabase();
        qWarning() <<"CREATING";
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
        qWarning()<< "Problem while creating employees table...";

    QFile f(documentsDirPath + "/DATA.csv");
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
                qWarning()<< "Problem while adding to Employees table...";
        }
        f.close();
    }
    QSqlDatabase::database().commit();

    QString employeePasswordReset = "CREATE TABLE EmployeePasswordReset("
                                    " id INTEGER,"
                                    " token TEXT NOT NULL,"
                                    " tokenExpiry TEXT NOT NULL,"
                                    " FOREIGN KEY (id) REFERENCES Employees(id));";

    if(!query.exec(employeePasswordReset))
        qWarning()<< "Problem while creating EmployeePasswordReset table...";

    QString clothesTypesTable = "CREATE TABLE ClothesTypes("
                                " typeId INTEGER PRIMARY KEY AUTOINCREMENT,"
                                " typeName TEXT NOT NULL UNIQUE,"
                                " typeImageSource TEXT NOT NULL);";

    if(!query.exec(clothesTypesTable))
        qWarning()<< "Problem while creating ClothesTypes table...";

    QString clothesTable = "CREATE TABLE Clothes("
                           " clothingId INTEGER PRIMARY KEY AUTOINCREMENT,"
                           " clothingName TEXT NOT NULL,"
                           " clothingDescription TEXT,"
                           " clothingImageSource TEXT NOT NULL,"
                           " typeId INTEGER,"
                           " FOREIGN KEY (typeId) REFERENCES ClothesTypes(typeId));";

    if(!query.exec(clothesTable))
        qWarning()<< "Problem while creating clothesTable table...";

    QString sizesTable = "CREATE TABLE Sizes("
                         " sizeId INTEGER PRIMARY KEY AUTOINCREMENT,"
                         " sizeName TEXT NOT NULL UNIQUE);";

    if(!query.exec(sizesTable))
        qWarning()<< "Problem while creating Sizes table...";

    QString clothesSizesTable = "CREATE TABLE ClothesSizes("
                                " clothingId INTEGER NOT NULL,"
                                " sizeId INTEGER NOT NULL,"
                                " count INTEGER,"
                                " PRIMARY KEY (clothingId, sizeId),"
                                " FOREIGN KEY (clothingId) REFERENCES Clothes(clothingId),"
                                " FOREIGN KEY (sizeId) REFERENCES sizes(sizeId));";

    if(!query.exec(clothesSizesTable))
        qWarning()<< "Problem while creating ClothesSizes table...";

    QString todoListTable = "CREATE TABLE TodoList("
                            " todoId INTEGER NOT NULL,"
                            " empId INTEGER NOT NULL,"
                            " todoDescription TEXT NOT NULL,"
                            " done INTEGER,"
                            " PRIMARY KEY (todoId),"
                            " FOREIGN KEY (empId) REFERENCES Employees(id));";

    if(!query.exec(todoListTable))
        qWarning()<< "Problem while creating todoList table...";

    QString todoListValues = "INSERT INTO TodoList(empId, todoDescription, done) VALUES"
                          " (\"1\", \"Durable and strong jeans!\", 0),"
                          " (\"2\", \"1231231\", 1),"
                             "(\"2\", \"123122231\", 1);";

    if(!query.exec(todoListValues))
        qWarning()<< "Problem while adding to ClothesTypes table...";

    QString typesValues = "INSERT INTO ClothesTypes(typeName, typeImageSource) VALUES"
                          " (\"Pants\", \"" + documentsDirPath + "/storage_images/types_images/pantsImage.png" + "\"),"
                                                                                               " (\"Shoes\", \"" + documentsDirPath + "/storage_images/types_images/shoesImage.png" + "\");";

    if(!query.exec(typesValues))
        qWarning()<< "Problem while adding to ClothesTypes table...";

    QString sizesValues = "INSERT INTO Sizes(sizeName) VALUES"
                          " (\"Small\"), (\"Medium\"), (\"Large\");";

    if(!query.exec(sizesValues))
        qWarning()<< "Problem while adding to Sizes table...";

    QString clothesValues = "INSERT INTO Clothes(clothingName, clothingDescription, clothingImageSource, typeId) VALUES"
                            " (\"Jeans\", \"Durable and strong jeans! \", \"" + documentsDirPath + "/storage_images/types_images/pantsImage.png" + "\", 1),"
                                                                                                 " (\"Chino Pants\", \"Durable and strong chinos!\" , \"" + documentsDirPath + "/storage_images/types_images/pantsImage.png" + "\", 1),"
                                                                                                 " (\"Boots\", \"Durable and strong boots!\" , \"" + documentsDirPath + "/storage_images/types_images/pantsImage.png" + "\", 2),"
                                                                                                 " (\"Sneakers\", \"Durable and strong sneakers!\", \"" + documentsDirPath + "/storage_images/types_images/pantsImage.png" + "\" , 2);";

    if(!query.exec(clothesValues))
        qWarning()<< "Problem while adding to Clothes table...";

    QString clothesSizesValues = "INSERT INTO ClothesSizes(clothingId, sizeId, count) VALUES"
                                 " (1, 2, 3),"
                                 " (1, 3, 2),"
                                 " (2, 2, 5),"
                                 " (3, 1, 21),"
                                 " (4, 1, 1);";

    if(!query.exec(clothesSizesValues))
        qWarning()<< "Problem while adding to ClothesSizes table...";
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
        qWarning()<< "Problem while getting password, isAdmin from Employees table...";
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
        qWarning()<< "Problem while getting email, firstname, lastname, id from Employees table...";
        return;
    }

    if(!userQuery.next())
        return;

    QString toEmail = userQuery.value(0).toString();
    QString firstname = userQuery.value(1).toString();
    QString lastname = userQuery.value(2).toString();
    int id = userQuery.value(3).toInt();

    //ADD SMTP login credentials from config.ini
    QSettings settings(documentsDirPath + "/config.ini", QSettings::IniFormat);
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
        qWarning() << "Failed to connect to host!";
        return;
    }

    smtp.login(fromEmail, password);

    if (!smtp.waitForAuthenticated()) {
        qWarning() << "Failed to login!";
        return;
    }

    smtp.sendMail(message);
    if (!smtp.waitForMailSent()) {
        qWarning() << "Failed to send mail!";
        return;
    }

    smtp.quit();
}

QString DatabaseController::createResetCode(const int &id)
{
    QSqlQuery deleteQuery;
    deleteQuery.prepare("DELETE FROM EmployeePasswordReset");

    if(!deleteQuery.exec()){
        qWarning()<< "Problem while deleting rows from EmployeePasswordReset table...";
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
        qWarning()<< "Problem while inserting into EmployeePasswordReset table...";
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
        qWarning()<< "Problem while getting id from Employees table...";
        return;
    }

    if(!userQuery.next()){
        emit wrongCode();
        return;
    }

    QSqlQuery resetQuery;
    resetQuery.prepare("SELECT token, tokenExpiry from EmployeePasswordReset where id = ?");
    resetQuery.addBindValue(userQuery.value(0).toInt());

    if(!resetQuery.exec()){
        qWarning()<< "Problem while getting token, tokenExpiry from EmployeePasswordReset table...";
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
        qWarning()<< "Problem while getting id from Employees table...";
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
        qWarning()<< "Problem while updating password in Employees table...";
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

    setIsCurrentlyAdmin(true);

    if(!insertQuery.exec()){
        qWarning()<< "Problem while inserting into Employees table...";
        return false;
    }

    emit rightLogin();
    return true;
}
