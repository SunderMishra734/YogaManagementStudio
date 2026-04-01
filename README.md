# Yoga Management Studio

Yoga Management Studio is a comprehensive full-stack solution designed to manage yoga centers, students, lecturers, classes, and schedules. It consists of a robust backend API and a dynamic web frontend.

## 🏗️ Architecture Overview

The project is structured into two main applications:

### 1. Api (Backend)
Follows the **Clean Architecture** (Onion Architecture) pattern:
- **Domain**: Core entities and repository interfaces.
- **Infrastructure**: Implementations of database context, repositories, and external services.
- **Application**: Business logic implemented using **CQRS** with **MediatR**.
- **RESTful API**: Serves JSON data to the frontend and other clients.

### 2. View (Frontend)
An **ASP.NET Core MVC** application that provides the user interface:
- **API Consumption**: Uses `HttpClient` to communicate with the Backend API.
- **Session Management**: Handles authentication using JWT-based cookies and session state.
- **Dynamic UI**: Responsive Razor views for students, lecturers, staff, and admins.

## 🚀 Technology Stack

- **Framework**: .NET 6.0
- **Database**: SQL Server + Entity Framework Core
- **Frontend**: ASP.NET Core MVC (Razor Views)
- **Authentication**: JWT Bearer Tokens (Backend), Session & Cookies (Frontend)
- **Design Patterns**: Repository & Unit of Work, CQRS (MediatR)
- **External Integrations**:
    - **FirebaseAdmin**: Push notifications and advanced auth operations.
    - **Google Cloud Storage**: Scalable image and asset storage.
    - **MailKit**: SMTP-based email communication for verification and notifications.
- **Libraries**: AutoMapper, FluentValidation, Swagger/OpenAPI.

## ✨ Key Features

### 👤 User Management
- **Role-Based Access Control**: Optimized workflows for Admin, Staff, Lecturer, and Student.
- **Secure Onboarding**: Registration with email verification and JWT-based session security.
- **Profile Customization**: Detailed user profiles with avatar support via Cloud Storage.

### 🧘 Class & Enrollment
- **Dynamic Scheduling**: Flexible class creation with configurable study slots.
- **Enrollment Flow**: Streamlined student enrollment with validation, capacity checks, and email confirmations.
- **Class Mobility**: Support for change class requests and lecturer assignments.

### 📅 Schedules & Availability
- **Instructor Availability**: Lecturers can manage their teaching windows.
- **Personalized Schedules**: Real-time schedule generation for both students (studying) and lecturers (teaching).

### 📧 Automated Communication
- **Verification Emails**: Automatic email dispatch during signup.
- **Enrollment Receipts**: Instant email confirmation upon successful class registration.

## 📁 Project Structure

```text
├── Api            # RESTful Backend API (Root Project)
│   ├── Application    # Business logic, Commands, Queries
│   ├── Domain         # Entities, Repository Interfaces
│   ├── Infrastructure # DB Context, Repo Implementations
│   └── Controllers    # API Controllers
├── View           # ASP.NET Core MVC Frontend
│   ├── Controllers    # UI Controllers (consuming Backend API)
│   ├── Views          # Razor Templates
│   └── wwwroot        # Static assets (CSS/JS)
└── DEPLOYMENT_GUIDE.md # Detailed deployment instructions
```

## 🛠️ Getting Started

1. **Backend Database**: Execute `0607.sql` in SQL Server.
2. **Api Startup**: Configure `appsettings.json` in the root `Api` project and run it. (Port: 7243)
3. **View Startup**: Configure the API URL in `View/Controllers` and run the `View` project.
4. **Docs**: Explore the API at `/swagger` on the backend port.

---
*A complete full-stack solution for yoga center operations.*
