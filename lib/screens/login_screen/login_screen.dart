import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:prova_flutter/core/auth/domain/entities/login_entity.dart';
import 'package:prova_flutter/core/login/presentation/bloc/login_bloc.dart';
import 'package:prova_flutter/core/login/presentation/bloc/login_events.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloC bloc;
  final _userController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    bloc = Injector.appInstance.get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover)),
          child: _buildBody(context),
        ),
      ]),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        buildUserWidget(context),
        const SizedBox(
          height: 15,
        ),
        buildPasswordWidget(context),
        const SizedBox(
          height: 15,
        ),
        buildLoginButton(context),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: buildPoliticasLink(context),
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ],
    ));
  }

  Widget buildUserWidget(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Usuário',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 300,
            child: TextField(
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.black),
              controller: _userController,
              decoration: InputDecoration(
                  errorText: _errorUserText,
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(5))),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPasswordWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Usuário',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 300,
          child: TextField(
            obscureText: true,
            cursorColor: Colors.black,
            style: const TextStyle(color: Colors.black),
            controller: _passwordController,
            decoration: InputDecoration(
                errorText: _errorPasswordText,
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.black,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5))),
          ),
        )
      ],
    );
  }

  String? get _errorUserText {
    final text = _userController.value.text;
    final validCharacters = RegExp(r'^[&%=]+$');

    if (text.isEmpty) {
      return '';
    }
    if (text.length < 2) {
      return 'Precisa ter mais do que 2 caracteres';
    }
    if (text.length > 20) {
      return 'Não pode ter mais do que 20 caracteres';
    }
    if (text.endsWith(' ')) {
      return 'Não pode terminar com espaço';
    }
    if (validCharacters.hasMatch(text)) {
      return 'Não são aceitos caracteres especiais';
    }
    return null;
  }

  String? get _errorPasswordText {
    final text = _userController.value.text;
    final validCharacters = RegExp(r'^[&%=]+$');

    if (text.isEmpty) {
      return '';
    }
    if (text.length < 3) {
      return 'Precisa ter mais do que 2 caracteres';
    }
    if (text.length > 21) {
      return 'Não pode ter mais do que 20 caracteres';
    }
    if (text.endsWith(' ')) {
      return 'Não pode terminar com espaço';
    }
    if (validCharacters.hasMatch(text)) {
      return 'Não são aceitos caracteres especiais';
    }
    return null;
  }

  Widget buildLoginButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        onPressed: () {
          setState(() {});
          if (_userController.value.text.isNotEmpty &&
              _passwordController.value.text.isNotEmpty &&
              _errorUserText == null &&
              _errorPasswordText == null) {
            bloc.loginDataSink.add(DoLoginEvent(LoginEntity(
              senha: _passwordController.text,
              user: _userController.text,
            )));
          } else {
            const SnackBar(content: Text("Por favor, revise as informações."));
          }
        },
        child: const Text(
          'Entrar',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
        ));
  }

  Widget buildPoliticasLink(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        child: const Text(
          "Política de privacidade",
          style: TextStyle(fontSize: 16),
        ),
        onTap: () => launchUrl(Uri.parse('https://www.google.com.br/')),
      ),
    );
  }
}
