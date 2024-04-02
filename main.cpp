#include "DatabaseConnection.h"
#include "EmployeesTab/Employees.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/ClothingStore/images/icon.ico"));
    QQmlApplicationEngine engine;

    DatabaseConnection *db = new DatabaseConnection(&app);
    Employees *emp = new Employees(&app, db->getDb());

    engine.rootContext()->setContextProperty("db", db); //change this to qmlSingleton

    qmlRegisterSingletonInstance("com.company.Employees", 1, 0, "Emp", emp);
    engine.rootContext()->setContextProperty("emp", emp);

    const QUrl url(u"qrc:/ClothingStore/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
