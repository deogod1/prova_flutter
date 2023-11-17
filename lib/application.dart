import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:prova_flutter/screens/login_screen/login_screen.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _removeFocus(context),
        child: const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: Locale('pt', 'BR'),
          home: LoginScreen(),
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
        ));
  }

  void _removeFocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}
