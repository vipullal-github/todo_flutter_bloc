# todo_bloc
# 🚀 Clean Architecture Todo App (Flutter & BLoC)

| Status | Code Quality |
| :--- | :--- |
| **Complete** | [![Code Coverage](https://img.shields.io/badge/Tests-High%20Coverage-brightgreen)](https://github.com/yourusername/yourreponame) |

A robust, production-ready Todo application built with **Flutter**, demonstrating best practices for **Clean Architecture** and **BLoC State Management**. This project is engineered for **maintainability, scalability, and testability**.

## ✨ Key Technical Highlights

This application is more than just a Todo list—it's a demonstration of high-quality software development principles:

### 1. 🏗️ Clean Architecture Implementation
The codebase is strictly separated into three core layers to ensure business rules remain independent of the UI and data sources:

* **Domain:** Contains the **core business logic** (Entities, Use Cases, Repository Interfaces). This layer is **UI-agnostic** and fully testable.
* **Data:** Implements the **Repository Interfaces** defined in the Domain layer, handling external data operations (e.g., local storage, API calls).
* **Presentation:** Contains the **Flutter UI** and the **BLoCs** that manage state for the views.

### 2. 🧠 BLoC State Management
We leverage the **BLoC (Business Logic Component)** library to enforce a predictable and reactive state model:

* **Event-Driven:** All user interactions are converted into **Events**, ensuring a single, clear path for state changes.
* **Separation of Concerns:** Achieves a complete separation between the UI layer and the core application logic.
* **Deterministic States:** Simplifies debugging and reasoning about complex side effects and asynchronous flows.

### 3. 🧪 Comprehensive Testing
The project is built with testing at its core, achieving high confidence for feature development and refactoring:

* **Unit Tests:** Thorough testing of **Domain Use Cases** and **Data Repositories**.
* **BLoC Tests:** Dedicated testing for all BLoC components using the powerful `bloc_test` package, ensuring state transitions are correct for every event.
* **Tools Used:** `flutter_test`, `bloc_test`, `mocktail`.

## 📂 Project Structure
