import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/login_providers.dart';
import 'home.dart';
import 'login.dart';

class Splash extends StatelessWidget {
  static const routeName = '/splash';

  @override
  Widget build(BuildContext context) {

    void changeScreen({required bool isLogined}) {
      if (isLogined==true) {
        Navigator.of(context).pushReplacementNamed(Home.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(Login.routeName);
      }
    }

    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProv, child) {
          print('Splash screen...');

          Timer(const Duration(milliseconds: 3000), () async {
            await loginProv.initSplash();
            if (loginProv.authToken != null || loginProv.authToken!.isEmpty) {
              print('loggined!');
              if (loginProv.accountInfo == null && loginProv.authToken!.isNotEmpty) {
                loginProv.detailAccount();
                loginProv.getProfileUser();
              }
              changeScreen(isLogined: true);
            } else {
              print('not login');
              changeScreen(isLogined: false);
            }
          });
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset('assets/images/splash_370.jpg', fit: BoxFit.fitWidth,),
          );
        },
      ),
    );
  }
}


