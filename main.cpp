#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickView>
#include <QQuickItem>
#include <QQmlContext>

#include "Init/DatabaseController.h"
#include "EmployeesTab/Employees.h"
#include "StorageTab/ClothesTypes/ClothesTypesModel.h"
#include "StorageTab/Clothes/ClothesModel.h"
#include "StorageTab/ClothingItem/ClothesSizesModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/ClothingStore/images/icon.ico"));
    QQmlApplicationEngine engine;

    DatabaseController *db = new DatabaseController(&app);
    qmlRegisterSingletonInstance("com.company.DatabaseController", 1, 0, "DbController", db);
    engine.rootContext()->setContextProperty("dbController", db);

    Employees *emp = new Employees(&app);
    qmlRegisterSingletonInstance("com.company.Employees", 1, 0, "Emp", emp);
    engine.rootContext()->setContextProperty("emp", emp);

    ClothesTypesModel *clothesTypesModel = new ClothesTypesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesTypesModel", 1, 0, "ClothesTypesModel", clothesTypesModel);
    engine.rootContext()->setContextProperty("clothesTypesModel", clothesTypesModel);

    ClothesModel *clothesModel = new ClothesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesModel", 1, 0, "ClothesModel", clothesModel);
    engine.rootContext()->setContextProperty("clothesModel", clothesModel);

    ClothesSizesModel *clothesSizesModel = new ClothesSizesModel(&app);
    qmlRegisterSingletonInstance("com.company.ClothesSizesModel", 1, 0, "ClothesSizesModel", clothesSizesModel);
    engine.rootContext()->setContextProperty("clothesSizesModel", clothesSizesModel);

    const QUrl url(u"qrc:/ClothingStore/Main.qml"_qs);

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
        &app, []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
