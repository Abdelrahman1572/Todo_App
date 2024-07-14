# ToDo App

This is a ToDo app built using Flutter and Dart programming language. The app uses BLoC architecture for state management and utilizes Shared Preferences and SQFLite for data storage and retrieval.

## Screenshots

![Apple iPhone 11 Pro Max Presentation](https://user-images.githubusercontent.com/88144060/166964996-06204a4c-2275-4b5e-888c-94c15181f6d2.png)
## Getting Started

To use this app, you will need to have Flutter and Dart installed on your system. You can follow the official Flutter installation guide for your platform [here](https://flutter.dev/docs/get-started/install). Once Flutter is installed, you can clone this repository and open the project in your preferred IDE.

### Dependencies

This app requires the following dependencies:

- `flutter_bloc`: A state management library for Flutter that implements the BLoC design pattern
- `sqflite`: A Flutter plugin for SQLite, a popular lightweight relational database
- `shared_preferences`: A Flutter plugin for storing key-value pairs on the device

These dependencies can be installed by running the following command in your terminal:


### Running the App

Once you have installed the dependencies, you can run the app on your device or emulator by running the following command in your terminal:

This will launch the app on your device or emulator and you can start using it immediately.

## Features

This app allows you to create and manage your ToDo list. You can perform the following actions:

- Add a new task to your list
- Edit an existing task
- Mark a task as complete
- Delete a task
- View all tasks
- View only completed tasks
- View only incomplete tasks

The app also stores your tasks locally on your device using SQFLite and Shared Preferences. This means that your tasks will persist even if you close the app or restart your device.

## Architecture

This app uses the BLoC (Business Logic Component) architecture for state management. The app is divided into three main components:

- `ui`: This component handles all of the UI logic and user interactions.
- `bloc`: This component implements the BLoC design pattern and handles all of the app's business logic and state management.
- `repository`: This component handles data storage and retrieval using SQFLite and Shared Preferences.

The BLoC component communicates with the UI component using `Stream`s, allowing the UI to update in real-time based on changes to the app's state.
