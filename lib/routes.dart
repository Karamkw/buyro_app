import 'package:buyro_app/core/constant/routes.dart';
import 'package:buyro_app/view/screen/auth/forgetpassword/checkcode.dart';
//import 'package:buyro_app/view/screen/auth/checkemail.dart';
import 'package:buyro_app/view/screen/auth/forgetpassword/forgetpassword.dart';
import 'package:buyro_app/view/screen/auth/forgetpassword/resetpassword.dart';
import 'package:buyro_app/view/screen/auth/forgetpassword/success_resetpassword.dart';
import 'package:buyro_app/view/screen/auth/verifycode.dart';
import 'package:buyro_app/view/screen/auth/login.dart';
import 'package:buyro_app/view/screen/auth/signup.dart';
//import 'package:buyro_app/view/screen/auth/success_signup.dart';
import 'package:buyro_app/view/screen/home/add_ad.dart';
import 'package:buyro_app/view/screen/home/addinfo.dart';
import 'package:buyro_app/view/screen/home/home.dart';
import 'package:buyro_app/view/screen/home/search.dart';
import 'package:buyro_app/view/screen/main_page.dart';
import 'package:buyro_app/view/screen/onboarding.dart';
import 'package:buyro_app/view/screen/other/changepassword.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  /////// Auth
  AppRoute.login: (context) => const Login(),
  AppRoute.signUp: (context) => const SignUp(),
  AppRoute.forgetPassword: (context) => const ForgetPassword(),
  AppRoute.verfiyCode: (context) => const VerfiyCode(),
   AppRoute.checkCode: (context) => const CheckCode(),
  AppRoute.resetPassword: (context) => const ResetPassword(),
  AppRoute.successResetpassword: (context) => const SuccessResetPassword(),
  //AppRoute.successSignUp: (context) => const SuccessSignUp(),

  ///OnBoarding
AppRoute.onBoarding: (context) => const OnBoarding(),

  ////inside app
 AppRoute.mainpage: (context) => const MainScreen(),
  AppRoute.home: (context) => const HomePage(),
  AppRoute.addad: (context) => const AddAdPage(),
  AppRoute.search: (context) => const SearchScreen(),
  AppRoute.addinfo: (context) => const AddInfoPage(),
  AppRoute.changePassword: (context) => const ChangePassword(),
};
