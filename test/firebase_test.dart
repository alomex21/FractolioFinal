import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';
import 'package:fractoliotesting/views/forgot_password.dart';
import 'package:mockito/mockito.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  group('ForgotPasswordView', () {
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      //AuthService.setInstance(mockAuthService);
    });

    testWidgets('should show snackbar on button press',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: ForgotPasswordView()));

      final emailField = find.byType(TextField);
      expect(emailField, findsOneWidget);

      await tester.enterText(emailField, 'test@example.com');
      await tester.tap(find.text('Send me a password reset link'));
      await tester.pumpAndSettle();

      verify(mockAuthService.sendPasswordReset('test@example.com')).called(1);

      final snackbar = find.byType(SnackBar);
      expect(snackbar, findsOneWidget);
      expect(
          find.text('Successfully Sent password reset link!'), findsOneWidget);
    });
  });
}
