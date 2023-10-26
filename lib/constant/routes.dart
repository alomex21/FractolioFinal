import 'package:flutter/material.dart';
import 'package:fractoliotesting/views/register_view2.dart';

import '../views/add_product.dart';
import '../views/change_password.dart';
import '../views/forgot_password.dart';
import '../views/login.dart';
import '../views/navigator_logic.dart';
import '../views/profile_screen.dart';
import '../views/register_view.dart';
import '../views/verify_email_view.dart';

const String loginRoute = '/login';
const String registerRoute = '/register';
//NUEVO REGISTER
const String registerRoute2 = '/register2';

const String verifyEmailRoute = '/verify';
const String navigator = '/menu';
const String editProfle = '/profile';
const String changePassword = '/edit_profile';
const String forgotPassword = '/forgotPassword';
const String addProduct = '/product_form';

Map<String, WidgetBuilder> buildRoutes() {
  return {
    loginRoute: (context) => const LoginView(),
    registerRoute: (context) => const RegisterView(),
    verifyEmailRoute: (context) => const VerifyEmailView(),
    navigator: (context) => const MenuPrincipal(),
    editProfle: (context) => const ProfileScreen(),
    changePassword: (context) => const EditProfile(),
    forgotPassword: (context) => const ForgotPasswordView(),
    addProduct: (context) => const ProductInfoForm(),
    registerRoute2: (context) => const RegisterPage2(),
  };
}
/* const loginRoute = '/login/';
const registerRoute = '/register/';
const profileScreen = 'profile_screen';
const verifyEmailRoute = '/verify-email/';
const editProfle = '/edit_profile';
const navigator = '/navigator';
const changePassword = '/change_password';
const forgotPassword = '/forgot_password';
const addProduct = '/add_product';
        // '/': (context) => const LoginView(),
        // '/mainmenu': (context) => const MainMenu(),
        // '/profile_screen': (context) => const ProfileScreen(),
        // '/navigator': (context) => const MenuPrincipal(),
 */
