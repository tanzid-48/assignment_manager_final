# 📱 Assignment Manager - Complete Working App

## ✅ এটি একটি সম্পূর্ণ কার্যকর Flutter অ্যাপ্লিকেশন!

**Student:** Md. Tanzid Mondol  
**ID:** 0322320105101048  
**Course:** CSE 3102 - Mobile Application Development  
**Semester:** 6th Semester  
**Institution:** Pundra University of Science & Technology

---

## 🚀 দ্রুত শুরু করুন (3 Steps)

### Step 1: Extract করুন
ZIP file extract করুন যেকোনো folder এ

### Step 2: Dependencies Install করুন
```bash
cd assignment_manager_final
flutter pub get
```

### Step 3: Run করুন
```bash
flutter run
```

**ব্যস! অ্যাপ চালু হয়ে যাবে!** 🎉

---

## ✨ সম্পূর্ণ Features

### Frontend (UI)
✅ **Splash Screen** - Animated intro (3 seconds)  
✅ **Home Screen** - Assignment list with color-coded cards  
✅ **Add/Edit Screen** - Form with validation  
✅ **Detail Screen** - Complete info with quick actions  
✅ **Statistics Dashboard** - Total, Pending, Active, Done counts  
✅ **Filter System** - Filter by status  
✅ **Pull to Refresh** - Swipe down to update  
✅ **Material Design 3** - Modern, beautiful UI  

### Backend (Database)
✅ **SQLite Database** - Local storage  
✅ **CRUD Operations:**
   - ✅ Create - Add new assignments
   - ✅ Read - Load all assignments
   - ✅ Update - Edit assignments
   - ✅ Delete - Remove assignments
✅ **Data Persistence** - Data saved permanently  
✅ **Error Handling** - Proper error messages  
✅ **Async Operations** - Non-blocking UI  

### Status Management
✅ **3 Status Levels:**
   - 🔴 Pending (Red)
   - 🟠 In-Progress (Orange)
   - 🟢 Completed (Green)
✅ **Quick Status Update** - One-tap status change  
✅ **Overdue Detection** - Shows "OVERDUE" label  
✅ **Days Remaining** - Countdown to deadline  

---

## 📂 Project Structure

```
assignment_manager_final/
├── lib/
│   ├── main.dart                      ✅ Entry point
│   ├── models/
│   │   └── assignment.dart            ✅ Data model
│   ├── database/
│   │   └── database_helper.dart       ✅ SQLite operations
│   └── screens/
│       ├── splash_screen.dart         ✅ Animated intro
│       ├── home_screen.dart           ✅ Main screen
│       ├── add_assignment_screen.dart ✅ Add/Edit form
│       └── assignment_detail_screen.dart ✅ Details view
├── android/
│   └── app/src/main/
│       └── AndroidManifest.xml        ✅ Android config
└── pubspec.yaml                       ✅ Dependencies
```

---

## 🎯 কীভাবে ব্যবহার করবেন

### 1. Assignment যোগ করুন
1. **+ Add Assignment** button click করুন
2. Fill করুন:
   - Title (required)
   - Subject (dropdown থেকে select)
   - Description (optional)
   - Deadline (calendar icon click করে select)
   - Status (Pending/In-Progress/Completed)
3. **Save Assignment** click করুন
4. ✅ Home screen এ card দেখবেন!

### 2. Assignment দেখুন
- Home screen এ card click করুন
- সম্পূর্ণ details দেখবেন
- Days remaining/Overdue status দেখবেন

### 3. Status পরিবর্তন করুন
- Detail screen এ যান
- Quick action button click করুন:
  - Mark In-Progress
  - Mark Completed
  - Mark Pending
- Card এর color সাথে সাথে পরিবর্তন হবে

### 4. Edit করুন
- Detail screen এ ✏️ Edit icon click করুন
- যেকোনো field পরিবর্তন করুন
- **Update Assignment** click করুন

### 5. Delete করুন
- Detail screen এ 🗑️ Delete icon click করুন
- Confirm করুন

### 6. Filter করুন
- Home screen এ ⚡ Filter icon click করুন
- Select করুন: All/Pending/In-Progress/Completed

---

## 🎨 Color Guide

| Status | Color | Meaning |
|--------|-------|---------|
| 🔴 Pending | Red | Not started |
| 🟠 In-Progress | Orange | Currently working |
| 🟢 Completed | Green | Finished |
| ⚠️ OVERDUE | Red Badge | Past deadline |

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
)
```

---

## 🔧 যদি কোন সমস্যা হয়

### Assignment add হচ্ছে না?

**Solution 1: Hot Restart**
```bash
# Terminal এ R (capital R) চাপুন
R
```

**Solution 2: Clean Build**
```bash
flutter clean
flutter pub get
flutter run
```

**Solution 3: Console Check করুন**
Android Studio এর **Run** tab এ দেখুন:
```
✅ Database table created successfully
✅ Assignment created with ID: 1
```

### App crash করছে?

```bash
flutter doctor
flutter clean
flutter pub get
flutter run --verbose
```

---

## ✅ পরীক্ষা করার Checklist

প্রত্যেকটি feature test করুন:

- [ ] App চালু হয় (Splash → Home)
- [ ] Assignment add করা যায়
- [ ] Home screen এ card দেখা যায়
- [ ] Statistics সঠিক দেখায়
- [ ] Detail screen খোলা যায়
- [ ] Status change করা যায়
- [ ] Edit করা যায়
- [ ] Delete করা যায় (confirmation সহ)
- [ ] Filter কাজ করে
- [ ] Pull to refresh কাজ করে
- [ ] App বন্ধ করে আবার চালু করলে data থাকে
- [ ] Overdue warning দেখায়
- [ ] Days remaining count সঠিক

**সব ✓ থাকলে app পারফেক্ট!** 🎉

---

## 📊 প্রজেক্ট বিবরণ

### Technology Stack
- **Framework:** Flutter 3.x
- **Language:** Dart
- **Database:** SQLite (sqflite package)
- **UI:** Material Design 3
- **State Management:** setState (built-in)

### Files Created
- **Dart Files:** 6
- **Model:** 1 (Assignment)
- **Database Helper:** 1
- **Screens:** 4
- **Total Lines:** ~1500+

### Development Time
- **Frontend:** 60%
- **Backend:** 40%

---

## 🎓 শিক্ষামূলক মূল্য

এই প্রজেক্ট থেকে শিখেছি:

### Technical Skills
✅ Flutter widget architecture  
✅ State management with setState  
✅ SQLite database integration  
✅ Async/await programming  
✅ CRUD operations  
✅ Form validation  
✅ Navigation & routing  
✅ Material Design implementation  
✅ Date/time handling  
✅ Error handling  

### Best Practices
✅ Clean code organization  
✅ Separation of concerns  
✅ Proper error messages  
✅ User feedback (SnackBars)  
✅ Data validation  
✅ Singleton pattern  

---

## 📱 System Requirements

- **Flutter SDK:** 3.0.0 or higher
- **Dart SDK:** 3.0.0 or higher
- **Android Studio:** Latest version
- **Android SDK:** API 21+ (Android 5.0+)

---

## 🎯 Instructor এর জন্য

### Mid-term Submission (Frontend)
✅ All screens designed and implemented  
✅ Beautiful UI with Material Design  
✅ Navigation working  
✅ Form validation  
✅ Responsive layout  

### Final Submission (Backend Integration)
✅ SQLite database integrated  
✅ All CRUD operations working  
✅ Data persistence verified  
✅ Error handling implemented  
✅ Statistics calculation  
✅ Full app functionality  

### Demonstration Points
1. **Splash Screen** - Professional intro
2. **Add Assignment** - Form with validation
3. **View List** - Color-coded cards
4. **Statistics** - Real-time counts
5. **Status Change** - Quick actions
6. **Edit/Delete** - Full CRUD
7. **Filter** - By status
8. **Data Persistence** - Close and reopen app

---

## 🏆 এই App এর বিশেষত্ব

✅ **Real-world Working** - Production-ready code  
✅ **Professional UI** - Material Design 3  
✅ **Reliable** - Proper error handling  
✅ **Fast** - Optimized database queries  
✅ **User-friendly** - Intuitive interface  
✅ **Well-documented** - Clear code comments  
✅ **Tested** - All features working  
✅ **Scalable** - Easy to add features  

---

## 📞 Support

যদি কোন সমস্যা হয়:

1. Console log check করুন
2. `flutter doctor` run করুন
3. `flutter clean && flutter pub get` করুন
4. README আবার পড়ুন

---

## 🎉 সাফল্যের চিহ্ন

যদি এগুলো দেখেন তাহলে সব ঠিক আছে:

```
🚀 App started and database initialized
✅ Database table created successfully
✅ Assignment created with ID: 1
✅ Loaded 1 assignments
```

---

**Made with ❤️ using Flutter**

**Student:** Md. Tanzid Mondol  
**Institution:** Pundra University of Science & Technology  
**Course:** Mobile Application Development Sessional
