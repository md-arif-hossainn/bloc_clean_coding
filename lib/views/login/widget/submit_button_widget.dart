import 'package:bloc_clean_coding/utils/enums.dart';
import 'package:bloc_clean_coding/utils/flush_bar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../bloc/login_bloc/login_bloc.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginButton({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //change listen in bloc listener then upgrade against this action
    return BlocListener<LoginBloc, LoginStates>(
      listenWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
      listener: (context, state) {

        if(state.postApiStatus == PostApiStatus.error){
          FlushBarHelper.flushBarErrorMessage(state.message.toString(), context);
        }

        if(state.postApiStatus == PostApiStatus.success){
          FlushBarHelper.flushBarSuccessMessage('Login successful', context);
        }

        // if(state.postApiStatus == PostApiStatus.loading){
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       const SnackBar(content: Text('Submitting....')),
        //     );
        // }

      },
      child: BlocBuilder<LoginBloc, LoginStates>(
          buildWhen: (current, previous) => current.postApiStatus != previous.postApiStatus,
          builder: (context, state) {
            if (kDebugMode) {
              print('build');
            }
            return ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('i am here');
                  context.read<LoginBloc>().add(LoginApi());
                }
              },
              child: state.postApiStatus == PostApiStatus.loading ? const CircularProgressIndicator() : const Text('Login'),
            );
          }),
    );
  }
}
