# Flutter Testing Laboratory 🧪

[![Flutter](https://img.shields.io/badge/Flutter-3.8.1+-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.8.1+-0175C2?logo=dart)](https://dart.dev)

A comprehensive Flutter testing laboratory demonstrating unit testing, widget testing, and integration testing practices across multiple real-world scenarios.

## 🎯 Overview

This project serves as a comprehensive testing laboratory for Flutter applications, showcasing best practices in writing maintainable and reliable tests. It includes three main feature modules, each with extensive test coverage:

- **User Registration Form** - Form validation and user input testing
- **Shopping Cart** - State management and business logic testing
- **Weather Display** - Asynchronous operations and data transformation testing

## ✨ Features

### 🔐 User Registration Form

- Full name validation (minimum 2 characters)
- Email validation with regex patterns
- Strong password validation (minimum 8 characters with uppercase, lowercase, numbers, and special characters)
- Password confirmation matching
- Loading states during form submission
- Success and error message display

### 🛒 Shopping Cart

- Add items to cart with customizable discounts
- Automatic quantity increment for duplicate items
- Update item quantities
- Remove individual items
- Clear entire cart
- Real-time calculations for:
  - Subtotal
  - Total discount
  - Final amount
  - Total item count

### 🌤️ Weather Display

- Multiple city selection (New York, London, Tokyo, Invalid City)
- Temperature unit conversion (Celsius ↔ Fahrenheit)
- Weather data fetching with loading states
- Error handling for invalid cities
- Display of:
  - Temperature
  - Weather description
  - Humidity
  - Wind speed
  - Weather icon

## 📁 Project Structure

```
flutter_testing_laboratory/
├── lib/
│   ├── main.dart                          # App entry point
│   ├── home_page.dart                     # Main navigation with tabs
│   ├── utils/
│   │   └── validation_helpers.dart        # Validation utility functions
│   └── widgets/
│       ├── user_registration_form.dart    # Registration form widget
│       ├── shopping_cart.dart             # Shopping cart widget & logic
│       └── weather_display.dart           # Weather display widget & data model
├── test/
│   ├── widget_test.dart                   # Main widget test
│   ├── utils/
│   │   ├── validation_helpers_test.dart   # Validation utilities tests
│   │   └── weather_conversion_test.dart   # Temperature conversion tests
│   └── widgets/
│       ├── user_registration_form_test.dart    # Form validation tests
│       ├── shopping_cart_test.dart             # Cart logic & UI tests
│       └── weather_display_test.dart           # Weather widget tests
└── pubspec.yaml
```

## 🧩 Widgets & Features

### 1. User Registration Form Widget

**File:** `lib/widgets/user_registration_form.dart`

**Features:**

- Four input fields: Full Name, Email, Password, Confirm Password
- Real-time validation feedback
- Loading indicator during form submission
- Success/error message display
- Form state management using `GlobalKey<FormState>`

**Validation Rules:**

- **Name:** Minimum 2 characters, cannot be empty
- **Email:** Must match standard email format (user@domain.ext)
- **Password:**
  - Minimum 8 characters
  - At least one uppercase letter
  - At least one lowercase letter
  - At least one number
  - At least one special character (!@#$%^&\*(),.?":{}|<>)
- **Confirm Password:** Must match the password field

### 2. Shopping Cart Widget

**File:** `lib/widgets/shopping_cart.dart`

**Components:**

- `CartItem` class: Model for individual cart items
- `ShoppingCartLogic` class: Business logic for cart operations
- `ShoppingCart` widget: UI implementation

**Operations:**

- `addItem()`: Add new items or increment quantity for existing items
- `removeItem()`: Remove all instances of an item
- `updateQuantity()`: Modify item quantity (removes if quantity ≤ 0)
- `clearCart()`: Remove all items from cart

**Calculations:**

- Subtotal: Sum of (price × quantity) for all items
- Total Discount: Sum of (price × quantity × discount) for all items
- Total Amount: Subtotal - Total Discount
- Total Items: Sum of quantities across all items

### 3. Weather Display Widget

**File:** `lib/widgets/weather_display.dart`

**Features:**

- City selector dropdown (4 cities)
- Temperature unit toggle (Celsius/Fahrenheit)
- Refresh button for manual data reload
- Loading state indicator
- Error state handling
- Weather data display with:
  - Weather icon
  - City name
  - Temperature (with automatic unit conversion)
  - Weather description
  - Humidity percentage
  - Wind speed

**Temperature Conversion:**

- Celsius to Fahrenheit: `(C × 9/5) + 32`
- Fahrenheit to Celsius: `(F - 32) × 5/9`

**Data Model:**

```dart
class WeatherData {
  final String city;
  final double temperatureCelsius;
  final String description;
  final int humidity;
  final double windSpeed;
  final String icon;
}
```

## 🧪 Testing Coverage

### Unit Tests

#### Validation Helpers Tests

**File:** `test/utils/validation_helpers_test.dart`

**Coverage:** 100% of validation logic

**Test Groups:**

1. **Email Validation** (14 tests)

   - Valid email formats (5 tests)
   - Invalid email formats (9 tests)
   - Edge cases: empty strings, missing domains, special characters

2. **Password Validation** (18 tests)

   - Strong password validation (5 tests)
   - Weak password detection (8 tests)
   - Specific error messages for each requirement (5 tests)

3. **Password Confirmation** (5 tests)

   - Matching passwords
   - Empty confirmation
   - Mismatched passwords

4. **Name Validation** (5 tests)
   - Valid names of various lengths
   - Empty/null inputs
   - Minimum length requirement

#### Weather Conversion Tests

**File:** `test/utils/weather_conversion_test.dart`

**Coverage:** Temperature conversion functions and data model

**Test Groups:**

1. **Temperature Conversion** (10 tests)

   - Celsius to Fahrenheit conversion (5 tests)
   - Fahrenheit to Celsius conversion (4 tests)
   - Reversibility verification (1 test)

2. **WeatherData.fromJson** (8 tests)
   - Complete JSON parsing
   - Default values for optional fields
   - Error handling for invalid JSON
   - Null safety validation

### Widget Tests

#### User Registration Form Tests

**File:** `test/widgets/user_registration_form_test.dart`

**Total Tests:** 19 widget tests

**Test Categories:**

1. **UI Rendering** (1 test)

   - Verify all form fields and buttons are displayed

2. **Name Validation** (2 tests)

   - Empty name error
   - Name too short error

3. **Email Validation** (4 tests)

   - Empty email error
   - Invalid format errors ("a@", "@b")
   - Valid email acceptance

4. **Password Validation** (6 tests)

   - Empty password error
   - Length requirement
   - Uppercase letter requirement
   - Lowercase letter requirement
   - Number requirement
   - Special character requirement

5. **Password Confirmation** (3 tests)

   - Empty confirmation error
   - Mismatch detection
   - Successful match

6. **Form Submission** (3 tests)
   - Invalid form submission
   - Valid form submission with loading state
   - Success message display

#### Shopping Cart Tests

**File:** `test/widgets/shopping_cart_test.dart`

**Total Tests:** 68 tests

**Test Categories:**

1. **CartItem Model** (3 tests)

   - Default values
   - Custom values
   - Quantity modification

2. **Add Item Operations** (6 tests)

   - Adding new items
   - Duplicate item handling
   - Multiple duplicate additions
   - Different items separately
   - Discount preservation

3. **Remove Item Operations** (3 tests)

   - Basic removal
   - Non-existent item handling
   - Multiple instance removal

4. **Update Quantity Operations** (5 tests)

   - Quantity updates
   - Zero quantity removal
   - Negative quantity handling
   - Non-existent item updates
   - Large quantity values

5. **Clear Cart Operations** (2 tests)

   - Clear all items
   - Clear empty cart

6. **Calculation Tests** (15 tests)

   - Subtotal calculations
   - Discount calculations
   - Total amount calculations
   - Item count calculations
   - Edge cases (empty cart, high discounts)

7. **Widget Interaction Tests** (34 tests)
   - Button functionality
   - Quantity controls
   - Cart display updates
   - UI state management
   - Real-time calculation updates

#### Weather Display Tests

**File:** `test/widgets/weather_display_test.dart`

**Total Tests:** 16 widget tests

**Test Categories:**

1. **Initial State** (2 tests)

   - Loading indicator display
   - Data loading completion

2. **UI Elements** (3 tests)

   - City dropdown presence
   - Temperature unit switch
   - Refresh button

3. **User Interactions** (4 tests)

   - City selection changes
   - Temperature unit toggle
   - Refresh functionality
   - Loading state during operations

4. **Data Display** (4 tests)

   - Weather icon display
   - Temperature with correct unit
   - Humidity and wind speed
   - Error state for invalid city

5. **Temperature Unit Display** (3 tests)
   - Celsius display
   - Fahrenheit display
   - Unit conversion accuracy

## 🚀 Installation

### Prerequisites

- Flutter SDK 3.8.1 or higher
- Dart SDK 3.8.1 or higher
- Android Studio / VS Code with Flutter extensions

### Setup Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/theahmedhany/flutter_testing_laboratory.git
   cd flutter_testing_laboratory
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 🧪 Running Tests

### Run All Tests

```bash
flutter test
```

### Run Tests by Category

**Unit Tests Only:**

```bash
flutter test test/utils/
```

**Widget Tests Only:**

```bash
flutter test test/widgets/
```

**Specific Widget Tests:**

```bash
# User Registration Form
flutter test test/widgets/user_registration_form_test.dart

# Shopping Cart
flutter test test/widgets/shopping_cart_test.dart

# Weather Display
flutter test test/widgets/weather_display_test.dart
```

## 📊 Test Results

### Overall Statistics

- **Total Test Files:** 5
- **Total Tests:** 120+
- **Test Categories:**
  - Unit Tests: 50+
  - Widget Tests: 70+
- **Code Coverage:** High coverage across all modules

### Test Breakdown by Module

| Module             | Test File                          | Tests | Status         |
| ------------------ | ---------------------------------- | ----- | -------------- |
| Validation Helpers | `validation_helpers_test.dart`     | 42    | ✅ All Passing |
| Weather Conversion | `weather_conversion_test.dart`     | 18    | ✅ All Passing |
| User Registration  | `user_registration_form_test.dart` | 19    | ✅ All Passing |
| Shopping Cart      | `shopping_cart_test.dart`          | 68    | ✅ All Passing |
| Weather Display    | `weather_display_test.dart`        | 16    | ✅ All Passing |

### Key Test Achievements

✅ **Comprehensive Validation Testing**

- All email validation edge cases covered
- Complete password strength requirements tested
- Form submission flow thoroughly tested

✅ **Business Logic Verification**

- Shopping cart calculations verified with multiple scenarios
- Discount application tested with various percentages
- Edge cases handled (negative quantities, large numbers)

✅ **UI Interaction Testing**

- Widget state changes verified
- User interactions simulated
- Asynchronous operations properly tested

✅ **Error Handling**

- Invalid inputs properly rejected
- Error messages displayed correctly
- Graceful degradation for edge cases

## 🎓 Key Testing Concepts Demonstrated

### 1. Unit Testing

- Pure function testing
- Business logic validation
- Edge case handling
- Input validation
- Data transformation

### 2. Widget Testing

- Widget rendering verification
- User interaction simulation
- State management testing
- Asynchronous operation testing
- UI element finding and verification

### 3. Test Organization

- Descriptive test names
- Logical test grouping
- Setup and teardown
- Test isolation
- DRY principles in testing

### 4. Best Practices

- Arrange-Act-Assert pattern
- Single responsibility per test
- Meaningful assertions
- Clear error messages
- Comprehensive coverage

---
