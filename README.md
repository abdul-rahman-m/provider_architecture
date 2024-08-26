# provider_stub

A new Flutter project.

## Overview

This project is a Flutter application utilizing the Provider package for state management.

## Features

- State management with Provider
- Clean Architecture
- MVVM Design Pattern
- Multiple Dart files for better organization

## Getting Started

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart: Included with Flutter SDK

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/provider_stub.git
    ```
2. Navigate to the project directory:
    ```sh
    cd provider_stub
    ```
3. Install dependencies:
    ```sh
    flutter pub get
    ```

### Running the App

Run the app on your preferred device or emulator:
```sh
flutter run
```

## Project Structure 

provider_stub/
├── lib/
│   ├── main.dart
│   ├── models/
│   ├── providers/
│   ├── remote/
│   ├── res/
│   ├── screens/
│   ├── utils/
│   └── widgets/
├── test/
├── assets/
├── .gitignore
├── pubspec.yaml
└── README.md

- main.dart: The entry point of the application.
- models/: Contains data models.
- providers/: Contains provider classes for state management.
- services/: Contains service classes for business logic.
- views/: Contains UI pages.
- widgets/: Contains reusable widgets.

## Usage
   
### Example
Here is an example of using a Provider in your Flutter app:

### Define a model:

class Counter {
  int value = 0;

  void increment() {
    value++;
  }
}

### Define a provider:

class CounterProvider with ChangeNotifier {
  Counter _counter = Counter();

  int get count => _counter.value;

  void increment() {
    _counter.increment();
    notifyListeners();
  }
}

### Use the provider in a widget:

class CounterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Provider Example')),
        body: Center(
          child: Consumer<CounterProvider>(
            builder: (context, counterProvider, child) {
              return Text('Count: ${counterProvider.count}');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<CounterProvider>().increment(),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}


## Resources
Lab: [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
Cookbook: [Useful Flutter samples](https://docs.flutter.dev/cookbook)
[Flutter Documentation](https://docs.flutter.dev/)