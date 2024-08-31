cmake_minimum_required(VERSION 3.16)

project(ClothingStore VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.6 REQUIRED COMPONENTS Quick Sql)

qt_standard_project_setup()

qt_add_executable(appClothingStore
    main.cpp

    Init/DatabaseController.h Init/DatabaseController.cpp

    EmployeesTab/Employees.h EmployeesTab/Employees.cpp

    StorageTab/ClothesTypesModel.h StorageTab/ClothesTypesModel.cpp
    StorageTab/ClothesModel.h StorageTab/ClothesModel.cpp
)

qt_add_qml_module(appClothingStore
    URI ClothingStore
    VERSION 1.0
    QML_FILES Main.qml
              MainApplication.qml

              Init/Login.qml
              Init/ForgotPassDialog.qml
              Init/Signup.qml

              EmployeesTab/Employees.qml
              EmployeesTab/EmployeesDelegate.qml
              EmployeesTab/EmployeeEdit.qml
              EmployeesTab/EmployeeSearch.qml
              EmployeesTab/EmployeeAdd.qml

              StorageTab/Storage.qml

              StorageTab/ClothesTypesDelegate.qml
              StorageTab/ClothesTypesAdd.qml
              StorageTab/ClothesTypes.qml
              StorageTab/ClothesTypesEditingDialog.qml

              StorageTab/ClothesDelegate.qml

              HomeTab/Home.qml

              Custom/Style.qml
              Custom/CustomButton.qml
              Custom/CustomInputBox.qml
              Custom/ThemeSwitch.qml

    RESOURCES images/icon.ico
              images/logo.png
              images/userImage.png
              images/addUserImage.png
              images/searchImage.png
              images/themeIcon.png

              Custom/qmldir
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appClothingStore PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appClothingStore
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appClothingStore
    PRIVATE Qt6::Quick
            Qt6::Sql

            bcryptcpp
            Qt${QT_VERSION_MAJOR}SmtpMime
)

qt_add_library(Bcrypt.cpp)
add_subdirectory(libraries/Bcryptcpp)
qt_add_library(Qt${QT_VERSION_MAJOR}SmtpMimeSmtpMime)
add_subdirectory(libraries/SmtpClient-for-Qt/src)

include(GNUInstallDirs)
install(TARGETS appClothingStore
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)


