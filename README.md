# GitExploreApp - iOS Project Readme

### Project Overview

>GitExploreApp is an iOS application that showcases the use of modern Swift concurrency, clean architecture, modularization, Combine, SwiftUI, UIKit, efficient dependency management, and the Coordinator pattern for navigation. The app is designed to run on a minimum iOS version of 16 and provides features for exploring GitHub users, repositories, and their forked users. The presentation layer is implemented using the MVVMC (Model-View-ViewModel-Coordinator) architecture pattern.


## Features

- Users can view a list of GitHub users.
- Users can explore repositories for a selected GitHub user.
- Repositories are displayed with their names, descriptions, and license.
- Users can view a list of users who have forked a specific GitHub repository.

## Project Structure

### The project is organized into several modules:

- GitExploreApp: This is the main application module responsible for user interface and navigation. The Coordinator pattern is employed to handle navigation between different screens.
- Domain: The Domain module holds the core business logic and models of the application. It defines the entities and use cases that drive the app's functionality.
- Core: The Core module serves as the data source module, handling data fetching.
- Networking: This module contains network-related code for making API requests to the GitHub API. It uses swift modern concurrency for handling asynchronous operations.
- Networking: This module contains storage-related code for making caching staff. It uses Core Data.
## Dependency Direction
![Alt text](README_FILES/CleanArchitectureDependencies.png?raw=true "Modules Dependencies")

## Presentation Layer

### MVVM Architecture

>The presentation layer of GitExploreApp is implemented using the MVVM (Model-View-ViewModel) architectural pattern. This pattern promotes separation of concerns and provides a clear structure for building user interfaces. Key components include:

- Model: Represents the application's data and business logic. In this case, the Domain module serves as the source of models.
- View: Represents the user interface and displays data to the user. Views are implemented using SwiftUI and UIKit.
- ViewModel: Acts as an intermediary between the Model and View. It contains presentation logic, handles user input, and prepares data for display. The MVVM pattern allows for unit testing of ViewModels, making it easier to verify their correctness.

## Domain Layer

>The Domain layer of GitExploreApp  plays a central role in defining the business logic and rules of your application which contains the  **Entities** +  **Use Cases** +  **Repositories Interfaces**

## Core Layer

>The Core layer of GitExploreApp is responsible for handling network calls and storage operations and provide a concrete implementation for Repositories Interfaces. contains **Repositories Implementations** + **API (Network)** + **Persistence DB**

## Coordinator Pattern

>The Coordinator pattern is used for navigation management in GitExploreApp. Coordinators help maintain a separation of concerns and facilitate navigation between different screens. Each coordinator is responsible for a specific flow within the app, making the navigation logic more organized and maintainable.

## Concurrency and Combine

>The project utilizes modern Swift concurrency to efficiently handle asynchronous tasks. Combine is used for managing and transforming data flows within the application.


## Extensive Unit Testing

>The project includes extensive unit testing for all use cases, ensuring code quality and reliability. Custom network testing with extended URLProtocol allows for comprehensive end-to-end flow testing. This approach guarantees that the app's functionality remains robust and reliable under various conditions.

## GitExploreApp Tech-Stack

- [Modularization] - Modular project structure: Separates the project into distinct modules to improve maintainability and scalability.
- [Coordinator Pattern] - Used for navigation management, keeping navigation logic organized and separate from the UI.
- [UIkit] - Utilized for specific UI components and screens within the app.
- [SwiftUI] - Used for building some parts of the user interface, providing a declarative and modern approach to UI development.
- [Combine] - A framework for processing values over time, used for managing data flows and asynchronous operations.
- [Swift Concurrency] - Utilizes Swift's concurrency features, such as async/await, to handle asynchronous tasks efficiently.
- [Callable user-defined nominal types](https://github.com/apple/swift-evolution/blob/main/proposals/0253-callable.md) -  By making these user-defined nominal types callable, you've enabled them to be used as functions. This allows you to interact with these types in a more natural and expressive way, making your code more readable and self-explanatory (used in **DefaultFetchUserFollowersCountUseCase**). 
- [DIContainer] - A custom dependency injection container for managing dependencies and their lifetimes.
- [CoreData] - Use Core Data Used to save your application’s permanent data for offline use, to cache temporary data, and to add undo functionality to your app on a single device.

## Minimum iOS Version

>GitExploreApp is designed to run on iOS 16 or later, making use of the latest iOS features and enhancements.
