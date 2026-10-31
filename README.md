# Hemanth Daily Expense & Multi-User Hub (Flutter Mobile App)

A modern, cross-platform Flutter application built with an Obsidian Glassmorphism theme, featuring credentials authentication, an interactive executive dashboard with expense analytics charts & live team chat, daily expense tracking with multi-user assignment, and team member management.

---

## 🔑 Authentication Credentials

- **Username**: `Hemanth`
- **Password**: `Hemanth`

*(Includes a "Quick Fill Credentials" helper chip on the login screen for instant 1-tap testing).*

---

## 🌟 Application Modules & Features

### 1. 🔐 Secure Authentication (`LoginScreen`)
- Form validation with reactive error alerts.
- Password visibility toggle (obscure / reveal).
- "Remember Login Session" preference switch.
- Auto-fill demo button for instant sign-in.

### 2. 📊 Executive Dashboard with Spending Chart & Team Chat (`HomeScreen`)
- **Executive Metric Cards**: Real-time Total Spend, Today's Daily Expense counter, and Active Multi-User tally.
- **Spending Analytics Chart**:
  - Weekly 7-day spending trend bar chart with highlighted daily volumes.
  - Category breakdown proportional progress bars with percentage shares.
- **Team Expense Chat & Discussion Stream**:
  - Live activity notes and chat stream directly on the dashboard.
  - Send messages in real-time (e.g. approve invoices, request receipts, or add expense notes).
  - Displays sender avatar, role badge, formatted timestamp, and message.

### 3. 💳 Daily Expense Management Screen (Screen 2) (`ExpenseScreen`)
- **Add Daily Expenses**: Form with title, amount (₹), multi-user assignment dropdown, category selection chips, payment method, date & time picker, and notes.
- **Update Daily Expenses**: Tap the edit icon (✏️) on any record to update amount, category, date, or notes in place.
- **Search & Category Filters**: Filter expenses instantly by category chips (*Cloud & Software, Food & Dining, Travel & Transport, Hardware, Utilities, Office*) or search title.
- **Delete Action**: Safe deletion with confirmation modal.

### 4. 👥 Multi-User Management Screen (Screen 1) (`UserManagementScreen`)
- **Multi-User Directory**: View team members with initials, avatar color codes, roles, emails, phone numbers, and join dates.
- **Add New User Modal**: Add new team members with customizable roles (*Admin / Lead, Engineering Member, Finance Manager, Operations Lead, Product Designer, QA Lead*) and custom avatar palettes.
- **Search Filter**: Search team members by name, username, or role.

---

## 📂 Project Architecture

```text
lib/
├── main.dart                  # App bootstrap, dark theme & Material 3 setup
├── constants/
│   ├── app_colors.dart        # Dark obsidian, electric indigo, cyan, emerald, amber tokens
│   └── app_styles.dart        # Typography & border radius definitions
├── models/
│   ├── user_model.dart        # Multi-user data model & initial team seeds
│   ├── expense_model.dart     # Daily expense model, category icons & color mapping
│   └── chat_model.dart        # Team expense chat stream model
├── services/
│   └── app_data_service.dart  # Central singleton state controller (ChangeNotifier)
├── widgets/
│   ├── glass_card.dart        # Frosted glass card with glow border
│   ├── custom_text_field.dart # Form input with prefix icons & validation
│   ├── custom_button.dart     # Gradient button with tap feedback
│   └── expense_chart.dart     # Weekly spending trend bar chart & category progress bars
└── screens/
    ├── login_screen.dart      # Login UI & Hemanth credentials check
    ├── home_screen.dart       # Dashboard tab, analytics chart, team chat & bottom navigation
    ├── expense_screen.dart    # Screen 2: Daily expense tracking, add/edit/delete
    └── user_management_screen.dart # Screen 1: Multi-user directory & add user modal
```

---

## 🚀 How to Run the App

```powershell
# 1. Navigate to the project directory
cd flutter_hemanth_app

# 2. Fetch packages (if needed)
flutter pub get

# 3. Launch in Google Chrome (Web)
flutter run -d chrome

# 4. Or launch as Windows Desktop Application
flutter run -d windows

# 5. Or launch on connected Android Device / Emulator
flutter run
```

---

*Author:* **Hemanthkumar N** — Full Stack Software Engineer  
*GitHub:* [https://github.com/Hemanth17071996](https://github.com/Hemanth17071996)
