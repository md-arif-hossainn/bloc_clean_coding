import 'package:bloc_clean_coding/bloc/login_bloc/login_bloc.dart';
import 'package:bloc_clean_coding/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'widget/widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final _fromKey = GlobalKey<FormState>();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = LoginBloc(loginRepository: getIt());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => _loginBloc,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _fromKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                EmailInputWidget(emailFocusNode: emailFocusNode),
                const SizedBox(height: 18,),
                InputPasswordWidget(passwordFocusNode: passwordFocusNode),
                const SizedBox(height: 40,),
                LoginButton(formKey: _fromKey),
              ],
            ),
          ),
        ),
      )
    );
  }
}
