import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home_page.dart';
import 'package:shop_app/screens/login_page.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}"),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, StreamSnapshot) {
              if (StreamSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${StreamSnapshot.error}"),
                  ),
                );
              }

              if (StreamSnapshot.connectionState == ConnectionState.active) {
                User _user = StreamSnapshot.data;
                if (_user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text(
                    "Kiểm tra trạng thái đăng nhập",
                    style: Constants.regularHeading,
                  ),
                ),
              );
            },
          ); //streambuilder để check trạng thái đăng nhập trực tiếp
        }
        return Scaffold(
          body: Center(
            child: Text(
              "LOADING...",
              style: Constants.regularHeading,
            ),
          ),
        );
      },
    );
  }
}
