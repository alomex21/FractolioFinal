import 'package:flutter_test/flutter_test.dart';
import 'package:fractoliotesting/services/auth/auth_exceptions.dart';
import 'package:fractoliotesting/services/auth/auth_provider.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late String testEmail;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    testEmail = 'testEmail@domain.com';
  });

  group('sendPasswordReset', () {
    test('succeeds when FirebaseAuth is called with correct email', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .thenAnswer((_) => Future.value());
      await AuthService(mockFirebaseAuth as AuthProvider)
          .sendPasswordReset(testEmail);
      verify(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test(
        'throws InvalidEmailAuthException when FirebaseAuth returns invalid-email error',
        () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .thenThrow(FirebaseAuthException(code: 'invalid-email'));
      expect(
          () async => await AuthService(mockFirebaseAuth as AuthProvider)
              .sendPasswordReset(testEmail),
          throwsA(isA<InvalidEmailAuthException>()));
    });

    test(
        'throws UserNotFoundAuthException when FirebaseAuth returns user-not-found error',
        () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));
      expect(
          () async => await AuthService(mockFirebaseAuth as AuthProvider)
              .sendPasswordReset(testEmail),
          throwsA(isA<UserNotFoundAuthException>()));
    });

    test('throws GenericAuthException on FirebaseAuth other error codes',
        () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .thenThrow(FirebaseAuthException(code: 'other-error-code'));
      expect(
          () async => await AuthService(mockFirebaseAuth as AuthProvider)
              .sendPasswordReset(testEmail),
          throwsA(isA<GenericAuthException>()));
    });

    test('throws GenericAuthException on any other exceptions', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: testEmail))
          .thenThrow(Exception());
      expect(
          () async => await AuthService(mockFirebaseAuth as AuthProvider)
              .sendPasswordReset(testEmail),
          throwsA(isA<GenericAuthException>()));
    });
  });
}
