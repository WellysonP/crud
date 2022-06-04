import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/pages/user_form.dart';
import 'package:flutter_crud/pages/user_list_page.dart';
import 'package:flutter_crud/provider/users.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Users(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: UserListPage(),
        routes: {
          AppRoutes.HOME: (context) => UserListPage(),
          AppRoutes.USER_FORM: (context) => UserForm(),
        },
      ),
    );
  }
}
