# HealthTrack – Scalable Health-Tech Mobile Application Prototype

## Overview

HealthTrack is a scalable health-tech mobile application prototype designed for frontline healthcare workers. The application supports patient onboarding, diagnosis image capture, AI-result simulation, and structured medical record management with local persistence.

This project focuses on clean architecture, modular design, state management, and scalability rather than pixel-perfect UI.

The goal was to demonstrate advanced-level mobile development skills including architecture thinking, separation of concerns, and maintainable code structure.

---

## Objective

To design and develop a scalable mobile health-tech prototype that supports:

- Patient onboarding
- Image upload and preview
- AI-result simulation
- Structured record management
- Modular architecture with clear separation of concerns

---

## Tech Stack

- Flutter
- Dart (Null Safety)
- Bloc (State Management)
- Hive (Local Persistence)
- Firebase Authentication
- Intl (Date Formatting)

---

## Architecture

The project follows a Feature-First Modular Architecture with Layered Separation.

The folder structure is organized as:

lib  
  core  
  features  
    auth  
    dashboard  
    diagnosis  
    patient  

Each feature follows a layered structure:

Data Layer  
- Models  
- Repository  

Presentation Layer  
- Bloc (event, state, bloc)  
- Pages  
- Feature-specific widgets  

Core Module  
- Shared theme configuration  
- Reusable widgets  
- Constants  

This structure ensures:

- Clear separation of concerns  
- Scalability  
- Maintainability  
- Testability  
- Reduced inter-feature coupling  

---


## Architecture Diagram

The application follows a Feature-First Modular Architecture with clear separation between Data and Presentation layers.

### High-Level Structure:
```
lib
│
├── main.dart
│
├── core
│   ├── theme.dart
│   ├── constants.dart
│   └── reusable widgets
│
└── features
    ├── auth
    │   ├── data
    │   │   └── auth_repository
    │   └── presentation
    │       ├── bloc
    │       ├── pages
    │       └── widgets
    │
    ├── dashboard
    │   ├── data
    │   └── presentation
    │       ├── bloc
    │       ├── pages
    │       └── widgets
    │
    ├── patient
    │   ├── data
    │   │   ├── models
    │   │   └── patient_repository
    │   └── presentation
    │       ├── bloc
    │       ├── pages
    │       └── widgets
    │
    └── diagnosis
        ├── data
        │   ├── models
        │   └── diagnosis_repository
        └── presentation
            ├── bloc
            ├── pages
            └── widgets
```

### Layered Flow Per Feature:

UI (Pages / Widgets)
        ↓
Bloc (State Management)
        ↓
Repository (Business Logic & Data Handling)
        ↓
Hive (Local Persistence)


### Data Flow Example (Add Diagnosis):

User Interaction
        ↓
DiagnosisPage dispatches AddDiagnosisEvent
        ↓
DiagnosisBloc processes event
        ↓
DiagnosisRepository stores data in Hive
        ↓
Updated state emitted
        ↓
UI rebuilds automatically


### This modular and layered approach ensures:

- Clear separation of concerns
- Independent feature scalability
- Maintainable codebase
- Easier future API integration
- Reduced tight coupling between modules

---

## Implemented Functional Modules

### 1. Authentication Module

- Login and Signup
- Input validation
- Error handling
- Firebase-based authentication

---

### 2. Dashboard Module

- Summary cards:
  - Total Patients
  - Total Reports
- Real-time updates using Hive listenable
- Smooth navigation to feature modules

---

### 3. Patient Management Module

- Add patient
- View patient list
- Structured patient model with fields:
  - Name
  - Age
  - Gender
  - Contact
  - Notes
- Local persistence using Hive

---

### 4. Image Capture & Upload Module

- Gallery image selection
- Image preview before saving
- Image stored via local file path
- Diagnosis linked to patient using patientId

---

### 5. AI Result Simulation Module

- Mock analysis result:
  - Normal
  - Attention
  - Risk
- Color-coded output
- Explainability section
- Date-based diagnosis tracking

---

### 6. Records & History Module

- Patient-wise diagnosis history
- Sorted by most recent first
- Diagnosis detail screen
- Persistent storage via Hive

---

## Data Modeling Strategy

Two primary Hive boxes are used:

Patients Box  
Stores patient profiles with unique incremental IDs.

Diagnoses Box  
Stores diagnosis records including:
- patientId reference
- image path
- analysis result
- explainability text
- dateTime

Diagnosis records are filtered by patientId for relational consistency.

Sorting is based on stored DateTime to ensure accurate chronological ordering.

---

## State Management

Bloc is used for:

- Authentication flow
- Patient management
- Diagnosis management
- Dashboard summary state

Business logic is fully separated from UI components.

---

## UI/UX Considerations

- Material Design compliant
- Consistent spacing and typography
- Clear visual hierarchy
- Color-coded diagnosis states
- Reusable components
- Simple and intuitive navigation

---

## Scalability Considerations

The architecture supports future enhancements such as:

- REST API integration
- Cloud storage
- Role-based access control
- Advanced filtering and search
- Unit testing
- Offline-first improvements
- Theme management (Light/Dark mode)

The modular feature-first structure allows independent expansion of each module.

---

## Known Limitations

- Camera integration not implemented (Gallery supported)
- Image compression not added
- Search and advanced filtering not implemented
- Settings module partially implemented
- UI polish can be further improved

These were intentionally deprioritized to focus on architectural quality and core workflow implementation.

---

## How to Run

1. Clone the repository
2. Navigate to the project directory
3. Run flutter pub get
4. Run flutter run


---

## Future Improvements

- Camera integration
- Image compression
- Search and filtering
- Dark mode toggle
- Profile screen
- Unit testing
- REST API mock integration

---

## Evaluation Alignment

Architecture & Scalability  
Feature-first modular architecture with layered separation.

Code Quality  
Bloc pattern, repository abstraction, structured models.

Functionality  
Core patient and diagnosis workflow implemented end-to-end.

UI/UX  
Material-based layout with consistent structure.

Documentation  
Clear explanation of architecture and implementation decisions.

---

## Author

Developed as part of an advanced mobile application development evaluation assignment.