# Package Tracker CLI

A command-line application written in **Dart** that tracks parcels using the **17TRACK API**.

The application allows users to track shipments from hundreds of carriers directly from the terminal by entering a tracking number. It communicates with the 17TRACK REST API, parses the returned JSON into strongly typed Dart models, and displays a clean, human-readable tracking summary.

---

## Features

* Track packages from multiple carriers
* Automatic carrier detection
* Interactive CLI prompts
* API key storage using a local `.env` file
* Input validation using Regular Expressions
* Object-oriented architecture
* Repository Pattern with Dependency Injection
* Strongly typed models for API responses
* Clean terminal output

---

## Example Output

```text
==================================================
PACKAGE TRACKER
==================================================

Tracking Number : RR123456789CN
Carrier         : China Post
Status          : In Transit
From            : Shenzhen, China
To              : Kabul, Afghanistan

Latest Update
--------------------------------------------------
2026-06-21 14:32
Package departed from sorting center

==================================================
Shipment History
==================================================
...
```

---


## 1. Clone the repository

```bash
git clone https://github.com/yourusername/package-tracker-cli.git

cd package-tracker-cli
```

---

## 2. Install dependencies

```bash
dart pub get
```

---

## 3. Create a 17TRACK account

Create a free account at

https://www.17track.net/

---

## 4. Generate an API Key

After logging in:

1. Open your Dashboard
2. Go to **Settings**
3. Open **API Management**
4. Generate an API Key
5. Copy the generated key

---

## 5. Save your API Key

Run the command that saves your API key.

The application stores it inside a local `.env` file.

Example:

```text
API_KEY=YOUR_API_KEY
```

The `.env` file is ignored by Git to prevent leaking credentials.

---

## 6. Track a package

```bash
track -t RR123456789CN
```

or simply

```bash
track
```

and the application will prompt for a tracking number interactively.

---

# Project Structure

```text
lib/

├── commands/
│   └── track_command.dart
│
├── data/
│   ├── local/
│   │     api_key_storage.dart
│   └── remote/
│         tracking_api_client.dart
│
├── models/
│   ├── parcel.dart
│   ├── history.dart
│   └── shipment_details.dart
│
├── repositories/
│   ├── tracking_repository.dart
│   └── tracking_repository_impl.dart
│
├── services/
│   └── tracking_service.dart
│
└── utils/
    ├── validators.dart
    └── extensions.dart
```

---

# Architecture

This project follows a simplified layered architecture inspired by production Flutter applications.

```
CLI Command
      │
      ▼
Tracking Service
      │
      ▼
Tracking Repository
      │
      ▼
Tracking API Client
      │
      ▼
17TRACK REST API
```

Each layer has a single responsibility:

### Commands

Responsible for:

* parsing command-line arguments
* user interaction
* displaying results

---

### Services

Contain application/business logic.

Services coordinate operations but remain independent of how data is retrieved.

---

### Repository

Acts as an abstraction between the business layer and the data source.

The rest of the application doesn't know whether data comes from:

* HTTP
* local storage
* cache
* database

Only the repository knows.

---

### API Client

Responsible only for:

* making HTTP requests
* decoding JSON responses
* communicating with the 17TRACK API

It contains no business logic.

---

# Technical Concepts Demonstrated

This project demonstrates:

* Dart asynchronous programming (`Future`, `async`, `await`)
* HTTP networking
* REST API consumption
* JSON serialization/deserialization
* Factory constructors
* Object-Oriented Programming
* Repository Pattern
* Dependency Injection
* Input validation using Regular Expressions
* Error handling with Exceptions
* Modular project organization
* Command-line argument parsing using the `args` package

---

# Technologies

* Dart
* HTTP package
* args package
* 17TRACK REST API

---

# What I Learned

While building this project I gained practical experience with:

* Designing layered applications
* Separating responsibilities using the Repository Pattern
* Dependency Injection
* Working with external REST APIs
* Parsing deeply nested JSON responses
* Structuring medium-sized Dart projects
* Building reusable CLI tools
* Writing maintainable and modular code

---

# License

This project is available under the MIT License.
