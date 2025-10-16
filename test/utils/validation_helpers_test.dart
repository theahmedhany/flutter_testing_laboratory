import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/utils/validation_helpers.dart';

void main() {
  group('Validation Helpers - Email Validation', () {
    test('isValidEmail returns true for valid email addresses', () {
      expect(ValidationHelpers.isValidEmail('test@ayhaga.com'), true);
      expect(ValidationHelpers.isValidEmail('user.name@ayhaga.com'), true);
      expect(ValidationHelpers.isValidEmail('user+tag@ayhaga.co.lk'), true);
      expect(ValidationHelpers.isValidEmail('test123@ayhaga.com'), true);
      expect(ValidationHelpers.isValidEmail('a@b.co'), true);
    });

    test('isValidEmail returns false for invalid email addresses', () {
      expect(ValidationHelpers.isValidEmail('testapp.com'), false);

      expect(ValidationHelpers.isValidEmail('test@'), false);

      expect(ValidationHelpers.isValidEmail('@ayhaga.com'), false);

      expect(ValidationHelpers.isValidEmail('test@ayhaga'), false);

      expect(ValidationHelpers.isValidEmail('a@'), false);
      expect(ValidationHelpers.isValidEmail('@b'), false);
      expect(ValidationHelpers.isValidEmail('a@b'), false);

      expect(ValidationHelpers.isValidEmail(''), false);

      expect(ValidationHelpers.isValidEmail('test@@ayhaga.com'), false);

      expect(ValidationHelpers.isValidEmail('test @ayhaga.com'), false);
      expect(ValidationHelpers.isValidEmail('test@ ayhaga.com'), false);
    });

    test('validateEmail returns null for valid emails', () {
      expect(ValidationHelpers.validateEmail('test@ayhaga.com'), null);
      expect(ValidationHelpers.validateEmail('user@ayhaga.org'), null);
    });

    test('validate Email returns error message for invalid emails', () {
      expect(ValidationHelpers.validateEmail(''), 'Please enter your email');
      expect(ValidationHelpers.validateEmail(null), 'Please enter your email');
      expect(
        ValidationHelpers.validateEmail('invalid@'),
        'Please enter a valid email address',
      );
      expect(
        ValidationHelpers.validateEmail('@ayhaga.com'),
        'Please enter a valid email address',
      );
      expect(
        ValidationHelpers.validateEmail('notanemail'),
        'Please enter a valid email address',
      );
    });
  });

  group('Validation Helpers - Password Validation', () {
    test('isValidPassword returns true for strong passwords', () {
      expect(ValidationHelpers.isValidPassword('Test123!'), true);
      expect(ValidationHelpers.isValidPassword('Str0ng@Pass'), true);
      expect(ValidationHelpers.isValidPassword('MyP@ssw0rd'), true);
      expect(ValidationHelpers.isValidPassword('Abcdef1!ghijk'), true);
      expect(ValidationHelpers.isValidPassword('C0mpl3x!Pass'), true);
    });

    test('isValidPassword returns false for weak passwords', () {
      expect(ValidationHelpers.isValidPassword('Test1!'), false);

      expect(ValidationHelpers.isValidPassword('test123!'), false);

      expect(ValidationHelpers.isValidPassword('TEST123!'), false);

      expect(ValidationHelpers.isValidPassword('TestPass!'), false);

      expect(ValidationHelpers.isValidPassword('Test1234'), false);

      expect(ValidationHelpers.isValidPassword(''), false);

      expect(ValidationHelpers.isValidPassword('TestPassword'), false);

      expect(ValidationHelpers.isValidPassword('12345678'), false);
    });

    test('validatePassword returns null for valid passwords', () {
      expect(ValidationHelpers.validatePassword('Test123!'), null);
      expect(ValidationHelpers.validatePassword('Str0ng@Pass'), null);
    });

    test('validatePassword returns specific error messages', () {
      expect(ValidationHelpers.validatePassword(''), 'Please enter a password');
      expect(
        ValidationHelpers.validatePassword(null),
        'Please enter a password',
      );
      expect(
        ValidationHelpers.validatePassword('Test1!'),
        'Password must be at least 8 characters',
      );
      expect(
        ValidationHelpers.validatePassword('test123!'),
        'Password must contain at least one uppercase letter',
      );
      expect(
        ValidationHelpers.validatePassword('TEST123!'),
        'Password must contain at least one lowercase letter',
      );
      expect(
        ValidationHelpers.validatePassword('TestPass!'),
        'Password must contain at least one number',
      );
      expect(
        ValidationHelpers.validatePassword('Test1234'),
        'Password must contain at least one special character',
      );
    });
  });

  group('ValidationHelpers - Password Confirmation', () {
    test('validatePasswordConfirmation returns null when passwords match', () {
      expect(
        ValidationHelpers.validatePasswordConfirmation('Test123!', 'Test123!'),
        null,
      );
      expect(
        ValidationHelpers.validatePasswordConfirmation('password', 'password'),
        null,
      );
    });

    test('validatePasswordConfirmation returns error when empty', () {
      expect(
        ValidationHelpers.validatePasswordConfirmation('', 'Test123!'),
        'Please confirm your password',
      );
      expect(
        ValidationHelpers.validatePasswordConfirmation(null, 'Test123!'),
        'Please confirm your password',
      );
    });

    test(
      'validatePasswordConfirmation returns error when passwords do not match',
      () {
        expect(
          ValidationHelpers.validatePasswordConfirmation(
            'Test123!',
            'Test456!',
          ),
          'Passwords do not match',
        );
        expect(
          ValidationHelpers.validatePasswordConfirmation(
            'password1',
            'password2',
          ),
          'Passwords do not match',
        );
      },
    );
  });

  group('ValidationHelpers - Name Validation', () {
    test('validateName returns null for valid names', () {
      expect(ValidationHelpers.validateName('John'), null);
      expect(ValidationHelpers.validateName('John Doe'), null);
      expect(ValidationHelpers.validateName('AB'), null);
      expect(ValidationHelpers.validateName('Mary Jane Watson'), null);
    });

    test('validateName returns error for invalid names', () {
      expect(ValidationHelpers.validateName(''), 'Please enter your full name');
      expect(
        ValidationHelpers.validateName(null),
        'Please enter your full name',
      );
      expect(
        ValidationHelpers.validateName('A'),
        'Name must be at least 2 characters',
      );
    });
  });
}
