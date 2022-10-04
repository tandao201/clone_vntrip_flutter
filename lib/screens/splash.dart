import 'dart:async';
import 'package:clone_vntrip/components/time.dart';
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

    loadData(LoginProvider loginProv) async {
      await loginProv.initSplash();
      if (loginProv.authToken != null || loginProv.authToken!.isEmpty) {
        debugPrint('loggined!');
        if (loginProv.accountInfo == null && loginProv.authToken!.isNotEmpty) {
          await loginProv.detailAccount();
          if (loginProv.profileUser == null) {
            loginProv.getProfileUser();
          }
        }
        changeScreen(isLogined: true);
      } else {
        debugPrint('not login');
        changeScreen(isLogined: false);
      }
    }

    return Scaffold(
      body: Consumer<LoginProvider>(
        builder: (context, loginProv, child) {
          debugPrint('Splash screen...');
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Builder(
              builder: (context) {
                loadData(loginProv);
                return Image.asset('assets/images/splash_370.jpg', fit: BoxFit.fitWidth,);
              },
            ),
          );
        },
      ),
    );
  }
}


