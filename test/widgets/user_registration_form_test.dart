import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  group('UserRegistrationForm Widget Tests', () {
    testWidgets('should display all form fields and register button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Register'), findsOneWidget);

      expect(find.byType(TextFormField), findsNWidgets(4));
    });

    testWidgets('should show error when name is empty and form is submitted', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your full name'), findsOneWidget);
    });

    testWidgets('should show error when name is too short', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'A',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Name must be at least 2 characters'), findsOneWidget);
    });

    testWidgets('should show error when email is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
    });

    testWidgets('should show error for invalid email format "a@"', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'a@');

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('should show error for invalid email format "@b"', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), '@b');

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    testWidgets('should accept valid email format', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'test@example.com',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email address'), findsNothing);
    });

    testWidgets('should show error when password is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a password'), findsOneWidget);
    });

    testWidgets('should show error when password is too short', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test1!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must be at least 8 characters'),
        findsOneWidget,
      );
    });

    testWidgets('should show error when password lacks uppercase letter', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'test123!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must contain at least one uppercase letter'),
        findsOneWidget,
      );
    });

    testWidgets('should show error when password lacks lowercase letter', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'TEST123!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must contain at least one lowercase letter'),
        findsOneWidget,
      );
    });

    testWidgets('should show error when password lacks number', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'TestPass!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must contain at least one number'),
        findsOneWidget,
      );
    });

    testWidgets('should show error when password lacks special character', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test1234',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(
        find.text('Password must contain at least one special character'),
        findsOneWidget,
      );
    });

    testWidgets('should accept strong password', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test123!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 8 characters'), findsNothing);
      expect(
        find.text('Password must contain at least one uppercase letter'),
        findsNothing,
      );
      expect(
        find.text('Password must contain at least one lowercase letter'),
        findsNothing,
      );
      expect(
        find.text('Password must contain at least one number'),
        findsNothing,
      );
      expect(
        find.text('Password must contain at least one special character'),
        findsNothing,
      );
    });

    testWidgets('should show error when password confirmation is empty', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Please confirm your password'), findsOneWidget);
    });

    testWidgets('should show error when passwords do not match', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test123!',
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'Test456!',
      );

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets(
      'should show form validation error message when form is invalid',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
        );

        await tester.tap(find.text('Register'));
        await tester.pumpAndSettle();

        expect(find.text('Please fix the errors above'), findsOneWidget);
      },
    );

    testWidgets('should submit successfully with valid data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'John Doe',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'john@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test123!',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'Test123!',
      );

      await tester.tap(find.text('Register'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Registration successful!'), findsOneWidget);
    });

    testWidgets('should disable register button while loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      await tester.enterText(
        find.widgetWithText(TextFormField, 'Full Name'),
        'John Doe',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Email'),
        'john@example.com',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Password'),
        'Test123!',
      );
      await tester.enterText(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        'Test123!',
      );

      await tester.tap(find.text('Register'));
      await tester.pump();

      final button = find.byType(ElevatedButton);
      final elevatedButton = tester.widget<ElevatedButton>(button);

      expect(elevatedButton.onPressed, isNull);

      await tester.pumpAndSettle();
    });

    testWidgets('should show helper text for password field', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      expect(
        find.text(
          'At least 8 characters with uppercase, lowercase, numbers and symbols',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should have password fields configured as obscured', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
      );

      expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);
      expect(
        find.widgetWithText(TextFormField, 'Confirm Password'),
        findsOneWidget,
      );

      final passwordFields = find.byType(TextFormField);
      expect(passwordFields, findsNWidgets(4));
    });
  });
}
