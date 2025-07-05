# Sprinto Project

This repository contains a full-stack project built with **.NET C# (Entity Framework Core)** as the backend API and **Flutter** for the frontend. The project is designed to run fully locally, using SQL Server Management Studio (SSMS) as the database.

---

## Project Overview

- **Backend:** ASP.NET Core Web API with Entity Framework Core  
- **Database:** SQL Server (using SSMS)  
- **Frontend:** Flutter (mobile and web app)  
- **Features:** Projects and Tasks management with CRUD operations  
- **Architecture:** MVC pattern on the backend, GetX for state management in Flutter  

---

## Prerequisites

Make sure you have the following installed on your machine:

- [.NET 8 SDK or compatible version](https://dotnet.microsoft.com/download)  
- SQL Server Management Studio (SSMS)  
- [Visual Studio 2022 or later](https://visualstudio.microsoft.com/) with ASP.NET workload installed  
- Flutter SDK  3.32.5
- An editor or IDE for Flutter development (e.g., VS Code, Android Studio)  

---

## Setup Instructions

### 1. Database Setup

- Open **SQL Server Management Studio (SSMS)** and connect to your local SQL Server instance.  
- Create a new database named `Sprinto` (or any name you prefer).  
- Ensure your connection string in the `appsettings.json` file in the API project points to your SQL Server instance and database correctly. Example:  
  ```json
  "ConnectionStrings": {
    "SprintoConnection": "Server=YOUR_SERVER_NAME;Database=Sprinto;User Id=YOUR_DB_USER;Password=YOUR_DB_PASSWORD;TrustServerCertificate=True;"
  }
## Setup Instructions

### 1. Apply Migrations and Create Tables

Run the following commands in the **Package Manager Console** inside Visual Studio to apply migrations and create tables:

```powershell
Add-Migration InitialCreate
Update-Database

## 2. Running the Backend API

- Open the backend API project in **Visual Studio**.  
- Build the project to restore all dependencies.  
- Run the API project (usually runs on `https://localhost:44388` or another port).  
- Confirm the API is running by visiting `https://localhost:44388/swagger` in your browser. You should see the Swagger UI for testing API endpoints.

---

## 3. Running the Flutter App

- Open your Flutter project in your preferred editor.  
- Locate the API base URL in your Flutter project configuration (`Api` class or constants).  
- Make sure it points to your running backend API URL, for example:

```dart
static const String url = "https://localhost:44388/api";

## Running the Flutter App

Run the Flutter app on your web platform .

The Flutter app will communicate with your local API to fetch and manage projects and tasks.

---

## Notes

- Since the API uses HTTPS with a self-signed certificate on localhost, you might need to **trust the localhost SSL certificate** or disable certificate verification in development.  
- The Flutter app uses **GetX** for state management and routing.  
- The backend API uses **Entity Framework Core** with code-first migrations for database management.  

---

## Additional Info

- The app supports adding, editing, deleting projects and tasks.  
- Tasks support drag-and-drop status updates (`To-Do`, `Doing`, `Done`).  

---

## Contact

If you encounter any issues or have questions, feel free to contact me.
