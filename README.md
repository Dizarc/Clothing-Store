# Seamless Manager - A Clothing Store Management System
This repository contains a **clothing Store Management System** built with **Qt QML** and **C++**.
Designed for managing employee information and inventory with tracking item additions and removals accross multiple clothing types, sizes and items. The project leverages an **SQLite database** for efficient storage and retrieval of data.

## Features

### Login/Signup Features
The application has a login feature with a signup page on first launch. The login feature has a username and password combo with the password being saved in the database as a hash utilizing **[BCrypt in C++](https://github.com/Dizarc/Bcryptcpp.git)**. There's also a forgot my password feature utilizing **[SmtpClient for Qt](https://github.com/bluetiger9/SmtpClient-for-Qt.git)**.

### Inventory Management
Manage various clothing types, sizes and items with pictures of each type and item with a description in each item and data about each item in storage.

### Employee Management
Manage each employee with their names/emails/phone numbers and passwords with a way to enable them as admin users and changing their password. It also has a search feature which can be used to search for an employee with any of the above data and an add employee feature which creates a new user with data given.

### Store Management
A simple to-do list system exists inside the application where each user can insert an item to the list, mark it as done and finally an admin can remove the items. 

### Dynamic UI
The application also has **dynamic resizing** of elements meaning the elements resize if the application window resizes and it also has intuitive sliding between the items in the main tab and between clothing types and clothing items. Some elements in the UI such as buttons also get disabled for non-admin users that are logged in.

### Custom UI Elements
The application contains **many custom UI elements** mainly for reusage but also for customizing UI colors.
Custom UI elements such as custom dialogs for confirming or getting information, a custom input box which is used for each user input functions, custom check boxes and spin boxes, buttons with one being reused many times inside the application and another for theme switching which the application supports with dark/light themes that both have custom colors that are hand picked and work well with the application concept.

### Model/view Architecture
The application uses **Qt model/view programming** for ease of management and separation of data in SQLite and the UI for the Employees, the To-Do list and the storage for each clothing type, size and item.

### Graphical Data Representation
The application has a **dynamic graph** in which a user can view the count of inserted items based on date/size/type and item. 

## Database Structure
The system uses an SQLite database with the following tables:
  * **Employees**: Contains each employees with their data such as firstname, lastname, username etc.
  * **EmployeePasswordReset**: Used only for resetting the password of a particular employee.
  * **TodoList**: Contains each todo list item.
  * **ChangeLog**: Used for the graphical data with the count of items added and removed.
  * **ClothesTypes**: Contains each clothing type the user has created.
  * **Sizes**: Stores all the available sizes for the application.
  * **Clothes**: Represents individual clothing items.
  * **ClothesSizes**: Associates items with specific sizes and tracks their count.

## Installation
1. Clone the repository:
```
git clone https://github.com/Dizarc/Clothing-Store.git
cd Clothing-Store
```
2. Setup Qt6 environment:
Ensure that Qt6 is installed and setup correctly. You can download Qt6 from [Qt's official website](https://www.qt.io/download-dev)

3. Run the application:
Open the project in Qt Creator and build/run the application

## Possible Improvements
Possible improvements include adding a clothing tag scanning system in which the application will automatically insert the clothing item inside the database, a sales system which will automatically calculate the monthly earnings/losses and represent the data in a graph.

## Images used in the application
 * **Application logo** background picture by Daian Gan: [Shirt Rack](https://www.pexels.com/photo/pile-of-shirts-hanged-in-shirt-rack-102129/)
 * **icons, all user images**: by  [flaticon](https://www.flaticon.com/uicons)

## Contributing
Contributions are welcome!
Please follow these steps:
1. Fork the repository.
2. Create a new branch for your feature:
```
git branch BRANCH-NAME
git checkout BRANCH-NAME
```
3. Commit your changes:
```
git add .
git commit -m "a short description of the change"
```
4. Push your changes:
```
git push
```
5. Create a pull request.

For more information checkout [Github's explanation](https://docs.github.com/en/get-started/exploring-projects-on-github/contributing-to-a-project)

## Screenshots

![Login](/Screenshots/image-6.png)

![Home](/Screenshots/image.png)

![storage types](/Screenshots/image-1.png)

![storage items](/Screenshots/image-2.png)

![item](/Screenshots/image-3.png)

![Employees](/Screenshots/image-4.png)

![Dark mode](/Screenshots/image-5.png)
