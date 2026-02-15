# 📱 Assignment Manager

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.19.0-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.3.0-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-3.0-003B57?style=for-the-badge&logo=sqlite&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

**A Smart Assignment Management App for Students**

Built with Flutter & SQLite | Material Design 3

[Features](#-features) • [Screenshots](#-screenshots) • [Installation](#-installation) • [Tech Stack](#-tech-stack) • [Author](#-author)

</div>

---

## 🎯 Overview

**Assignment Manager** is a mobile application designed to help students effectively manage their academic assignments, track deadlines, and boost productivity. Built with Flutter and powered by SQLite database, it offers a fast and reliable offline-first experience.

---

## ✨ Features

### 📝 Assignment Management
- ➕ **Create Assignments** - Add new assignments with title, subject, description, and deadline
- ✏️ **Edit & Update** - Modify assignment details anytime
- 🗑️ **Delete Assignments** - Remove completed or cancelled assignments
- 📊 **View All** - See all assignments in one organized list

### 🎯 Status Tracking
- 🔴 **Pending** - Assignments not yet started
- 🟠 **In-Progress** - Currently working on
- 🟢 **Completed** - Finished assignments
- ⚡ **Quick Status Update** - Change status with one tap

### 📅 Deadline Management
- ⏰ **Countdown Timer** - See days remaining for each assignment
- ⚠️ **Overdue Detection** - Automatic alerts for missed deadlines
- 📆 **Date Picker** - Easy deadline selection
- 🔔 **Visual Indicators** - Color-coded deadline warnings

### 📊 Statistics Dashboard
- 📈 **Total Count** - See all assignments at a glance
- 🔴 **Pending Count** - Track pending work
- 🟠 **Active Count** - Monitor ongoing tasks
- 🟢 **Completed Count** - Measure your progress

### 🔍 Filter & Sort
- **Filter by Status** - View Pending, In-Progress, or Completed only
- **Sort by Deadline** - Assignments ordered by due date
- **Pull to Refresh** - Quick data synchronization

### 🎨 Beautiful UI
- 💫 **Animated Splash Screen** - Professional app introduction
- 🎨 **Material Design 3** - Modern, clean interface
- 🎭 **Color-Coded Cards** - Visual status indicators
- 📱 **Responsive Layout** - Works on all screen sizes

---

## 📸 Screenshots

<div align="center">

### Home Screen
<img src="screenshots/home_screen.png" alt="Home Screen" width="250"/>

*Main dashboard with assignment list and statistics*

---

### Add Assignment
<img src="screenshots/add_screen.png" alt="Add Assignment" width="250"/>

*Create new assignment with all details*

---

### Assignment Details
<img src="screenshots/detail_screen.png" alt="Assignment Details" width="250"/>

*View complete information with quick actions*

---

### Filter Options
<img src="screenshots/filter_screen.png" alt="Filter Menu" width="250"/>

*Filter assignments by status*

</div>

> **Note:** Screenshots will be added soon

---

## 🚀 Installation

### Prerequisites
```
✓ Flutter SDK 3.0.0+
✓ Dart SDK 3.0.0+
✓ Android Studio or VS Code
✓ Android SDK API Level 21+
```

### Quick Start

```bash
# 1. Clone the repository
git clone https://github.com/tanzid-48/assignment_manager_final.git

# 2. Navigate to project directory
cd assignment_manager_final

# 3. Install dependencies
flutter pub get

# 4. Run the app
flutter run
```

---

## 📖 How to Use

### ➕ Adding an Assignment

1. Tap the **+** button on home screen
2. Fill in the form:
   - **Title** (Required) - e.g., "Mathematics Assignment"
   - **Subject** (Required) - Select from dropdown
   - **Description** (Optional) - Add notes
   - **Deadline** (Required) - Pick a date
   - **Status** (Required) - Pending/In-Progress/Completed
3. Tap **Save Assignment**

### 📝 Viewing Details

- Tap any assignment card on home screen
- See complete information including:
  - Title, Subject, Description
  - Deadline with countdown
  - Current status
  - Creation date

### ✏️ Editing an Assignment

1. Open assignment details
2. Tap the **Edit** icon (✏️) at top-right
3. Modify any field
4. Tap **Update Assignment**

### 🗑️ Deleting an Assignment

1. Open assignment details
2. Tap the **Delete** icon (🗑️) at top-right
3. Confirm deletion

### 🎯 Changing Status

In assignment details screen, use quick action buttons:
- **Mark as In-Progress** - When you start working
- **Mark as Completed** - When finished
- **Mark as Pending** - To reset status

### 🔍 Filtering Assignments

1. Tap the **Filter** icon (⚡) on home screen
2. Select:
   - **All** - Show everything
   - **Pending** - Only pending assignments
   - **In-Progress** - Only active work
   - **Completed** - Only finished tasks

---

## 🛠️ Tech Stack

### Frontend
- **Flutter 3.19.0** - Cross-platform UI framework
- **Dart 3.3.0** - Programming language
- **Material Design 3** - UI design system

### Backend & Storage
- **SQLite** - Local database
- **sqflite ^2.3.0** - Flutter SQLite plugin
- **path_provider ^2.1.1** - File system access

### Additional Packages
- **intl ^0.19.0** - Date/time formatting
- **path ^1.8.3** - Path manipulation utilities

---

## 📂 Project Structure

```
assignment_manager_final/
│
├── lib/
│   ├── main.dart                          # App entry point
│   │
│   ├── models/
│   │   └── assignment.dart                # Assignment data model
│   │
│   ├── database/
│   │   └── database_helper.dart           # SQLite CRUD operations
│   │
│   └── screens/
│       ├── splash_screen.dart             # Animated splash screen
│       ├── home_screen.dart               # Main dashboard
│       ├── add_assignment_screen.dart     # Add/Edit form
│       └── assignment_detail_screen.dart  # Detail view
│
├── android/                                # Android configuration
├── pubspec.yaml                           # Project dependencies
└── README.md                              # This file
```

**Total Files:** 135+  
**Lines of Code:** 6,500+  
**Development Time:** 4 weeks

---

## 💾 Database Schema

```sql
CREATE TABLE assignments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  subject TEXT NOT NULL,
  description TEXT,
  deadline TEXT NOT NULL,
  status TEXT NOT NULL,
  created_at TEXT NOT NULL
);
```

**Fields:**
- `id` - Unique identifier (auto-increment)
- `title` - Assignment title
- `subject` - Subject name (Mathematics, Science, etc.)
- `description` - Optional notes
- `deadline` - Due date (ISO 8601 format)
- `status` - Pending / In-Progress / Completed
- `created_at` - Creation timestamp

---

## 🎨 Color Scheme

| Status | Color | Usage |
|--------|-------|-------|
| 🔴 Pending | Red (#F44336) | Not started |
| 🟠 In-Progress | Orange (#FF9800) | Working on it |
| 🟢 Completed | Green (#4CAF50) | Finished |
| ⚠️ Overdue | Dark Red (#C62828) | Past deadline |

---

## 🚀 Future Enhancements

### Planned Features
- 🔔 Push notifications for deadline reminders
- 🌙 Dark mode support
- 🔍 Search functionality
- 📊 Advanced statistics with charts
- 📤 Export assignments to PDF
- ☁️ Cloud backup (Google Drive integration)
- 🎤 Voice input for creating assignments
- 📸 OCR for scanning assignment details
- 👥 Share assignments with classmates
- 🌐 Multi-language support (Bengali, Hindi)

---

## 📱 Build for Production

### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

---

## 📄 License

This project is licensed under the **MIT License**.

```
MIT License

Copyright (c) 2024 Md. Tanzid Mondol

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
```

---

## 👨‍💻 Author

<div align="center">

### Md. Tanzid Mondol

**🎓 Student | 💻 Flutter Developer**

**Pundra University of Science & Technology**

---

📚 **Course:** CSE 3102 - Mobile Application Development  
🆔 **Student ID:** 0322320105101048  
📖 **Semester:** 6th Semester

---

📧 **Email:** mdtanzid.525@gmail.com  
🐙 **GitHub:** [@tanzid-48](https://github.com/tanzid-48)  
🔗 **Repository:** [assignment_manager_final](https://github.com/tanzid-48/assignment_manager_final)

</div>

---

## 🙏 Acknowledgments

Special thanks to:

- **Fahim Sir** - Course Instructor and Project Mentor  
  For guidance, feedback, and continuous support throughout the development

- **Pundra University of Science & Technology**  
  For providing academic resources and learning environment

- **Flutter Team**  
  For creating an amazing cross-platform framework

- **Open Source Community**  
  For packages and inspiration

---

## 📞 Support

### Need Help?

- 🐛 **Report a Bug:** [Open an Issue](https://github.com/tanzid-48/assignment_manager_final/issues)
- 💡 **Feature Request:** [Start a Discussion](https://github.com/tanzid-48/assignment_manager_final/discussions)
- 📧 **Email:** mdtanzid.525@gmail.com

---

## 🌟 Show Your Support

If this project helped you, please give it a ⭐️ on GitHub!

**Share with your classmates and help them stay organized too!**

---

## 📈 Project Stats

<div align="center">

![GitHub Stars](https://img.shields.io/github/stars/tanzid-48/assignment_manager_final?style=social)
![GitHub Forks](https://img.shields.io/github/forks/tanzid-48/assignment_manager_final?style=social)
![GitHub Watchers](https://img.shields.io/github/watchers/tanzid-48/assignment_manager_final?style=social)

</div>

---

<div align="center">

### Made with ❤️ using Flutter

**Pundra University of Science & Technology**

**Mobile Application Development Project - 2024**

---

[⬆ Back to Top](#-assignment-manager)

---

**© 2024 Md. Tanzid Mondol | All Rights Reserved**

</div>
