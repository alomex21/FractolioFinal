import 'package:flutter/material.dart';
import 'package:fractoliotesting/constant/routes.dart';
import 'package:fractoliotesting/dialogs/error_dialog.dart';
import 'package:fractoliotesting/services/auth/auth_exceptions.dart';
import 'package:fractoliotesting/services/auth/auth_service.dart';

//BOTON PERFIL
class BotonPerfil extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const BotonPerfil({
    super.key,
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(width: 0, color: const Color(0x00ffffff)),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 4, 0),
                child: EditText(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//EDITAR TEXT DE BOTON PERFIL
class EditText extends StatelessWidget {
  final String displayText;
  const EditText(this.displayText, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      displayText,
      style: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          fontStyle: FontStyle.normal),
    );
  }
}

//LOGIN STATE
class LoginState extends StatelessWidget {
  const LoginState({
    super.key,
    required TextEditingController email,
    required TextEditingController password,
    required this.mounted,
  })  : _email = email,
        _password = password;

  final TextEditingController _email;
  final TextEditingController _password;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        FocusScope.of(context).unfocus();
        final email = _email.text;
        final password = _password.text;
        try {
          await AuthService.firebase().logIn(
            email: email,
            password: password,
          );
          final user = AuthService.firebase().currentUser;
          if (user?.isEmailVerified ?? false) {
            //user verified
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                navigator,
                (route) => false,
              );
            }
          } else {
            //Not verified yet
            if (mounted) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                verifyEmailRoute,
                (route) => false,
              );
            }
          }
        } on UserNotFoundAuthException {
          await showErrorDialog(
            context,
            "User not found",
          );
        } on WrongPasswordAuthException {
          await showErrorDialog(
            context,
            "Wrong credentials",
          );
        } on GenericAuthException {
          await showErrorDialog(
            context,
            'Authentication Error',
          );
        }
      },
      child: const Text('Login'),
    );
  }
}
