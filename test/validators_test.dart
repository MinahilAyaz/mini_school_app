import 'package:flutter_test/flutter_test.dart';
import 'package:mini_school_app/utils/validators.dart';

void main() {
  group('Validators', () {
    // ============ Email Validation Tests ============
    group('validateEmail', () {
      test('returns null for valid email', () {
        const validEmail = 'test@example.com';
        expect(Validators.validateEmail(validEmail), null);
      });

      test('returns error for invalid email format', () {
        const invalidEmail = 'invalid-email';
        expect(
          Validators.validateEmail(invalidEmail),
          'Please enter a valid email address',
        );
      });

      test('returns error for email without domain', () {
        const invalidEmail = 'test@';
        expect(
          Validators.validateEmail(invalidEmail),
          'Please enter a valid email address',
        );
      });

      test('returns error for empty email', () {
        expect(Validators.validateEmail(''), 'Email is required');
      });

      test('returns error for null email', () {
        expect(Validators.validateEmail(null), 'Email is required');
      });

      test('returns null for complex valid email', () {
        const complexEmail = 'user.name+tag@example.co.uk';
        expect(Validators.validateEmail(complexEmail), null);
      });
    });

    // ============ Password Validation Tests ============
    group('validatePassword', () {
      test('returns null for valid password', () {
        const validPassword = 'password123';
        expect(Validators.validatePassword(validPassword), null);
      });

      test('returns error for empty password', () {
        expect(Validators.validatePassword(''), 'Password is required');
      });

      test('returns error for null password', () {
        expect(Validators.validatePassword(null), 'Password is required');
      });

      test('returns error for short password', () {
        const shortPassword = 'abc';
        expect(
          Validators.validatePassword(shortPassword),
          'Password must be at least 4 characters',
        );
      });

      test('returns null for minimum length password', () {
        const minPassword = 'test';
        expect(Validators.validatePassword(minPassword), null);
      });

      test('returns null for long password', () {
        const longPassword = 'this-is-a-very-long-secure-password';
        expect(Validators.validatePassword(longPassword), null);
      });
    });

    // ============ Name Validation Tests ============
    group('validateName', () {
      test('returns null for valid name', () {
        const validName = 'John Doe';
        expect(Validators.validateName(validName), null);
      });

      test('returns error for empty name', () {
        expect(Validators.validateName(''), 'Name is required');
      });

      test('returns error for single character name', () {
        expect(
          Validators.validateName('J'),
          'Name must be at least 2 characters',
        );
      });

      test('returns error for name with numbers', () {
        const invalidName = 'John123';
        expect(
          Validators.validateName(invalidName),
          'Name can only contain letters, spaces, and hyphens',
        );
      });

      test('returns null for name with hyphen', () {
        const hyphenName = 'Mary-Jane';
        expect(Validators.validateName(hyphenName), null);
      });

      test('returns null for name with apostrophe', () {
        const apostropheName = "O'Brien";
        expect(Validators.validateName(apostropheName), null);
      });
    });

    // ============ Phone Validation Tests ============
    group('validatePhone', () {
      test('returns null for valid 10-digit phone', () {
        const validPhone = '1234567890';
        expect(Validators.validatePhone(validPhone), null);
      });

      test('returns null for phone with hyphens', () {
        const formattedPhone = '123-456-7890';
        expect(Validators.validatePhone(formattedPhone), null);
      });

      test('returns null for phone with parentheses', () {
        const formattedPhone = '(123) 456-7890';
        expect(Validators.validatePhone(formattedPhone), null);
      });

      test('returns error for too short phone', () {
        const shortPhone = '12345';
        expect(
          Validators.validatePhone(shortPhone),
          'Phone number must be at least 10 digits',
        );
      });

      test('returns error for empty phone', () {
        expect(Validators.validatePhone(''), 'Phone number is required');
      });
    });
  });
}
