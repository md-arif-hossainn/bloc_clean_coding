import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/login_bloc/login_bloc.dart';

class InputPasswordWidget extends StatelessWidget {
  final FocusNode passwordFocusNode;

  const InputPasswordWidget({Key? key, required this.passwordFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginStates>(
        buildWhen: (current, previous) =>current.password != previous.password,
        builder: (context, state){
          print('build');
          return TextFormField(
            keyboardType: TextInputType.text,
            focusNode: passwordFocusNode,
            obscureText: true,
            decoration: const InputDecoration(
              hintText: 'password',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<LoginBloc>().add(PasswordChanged(password: value));
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter password';
              }
              if (value.length < 6) {
                return 'Please enter password greater than 6 char';
              }
              return null;
            },
            onFieldSubmitted: (value) {},
          );
        }
    );
  }
}