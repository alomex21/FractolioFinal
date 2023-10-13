import 'package:fractoliotesting/services/auth/auth_provider.dart';
import 'package:fractoliotesting/services/auth/auth_user.dart';
import 'package:fractoliotesting/services/auth/firebase_auth_provider.dart';

class AuthService implements AuthProvider {
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  final AuthProvider provider;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<void> initialize() => provider.initialize();

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => provider.logOut();

  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();

  @override
  Future<void> sendPasswordReset(
    String toEmail,
  ) =>
      provider.sendPasswordReset(toEmail);
}
