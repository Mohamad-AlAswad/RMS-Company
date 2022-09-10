import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rms_company/presentation/pages/authentication/company_select.dart';

import 'Pages/Authentication/authenticate.dart';
import 'Pages/Authentication/login.dart';
import 'Pages/Authentication/signup.dart';
import 'blocs/authentication/auth_bloc.dart';
import 'controllers/controllers.dart';

class BlocBuilderWidget extends StatelessWidget {
  const BlocBuilderWidget({
    Key? key,
    required this.controllers,
    required this.initialState,
  }) : super(key: key);

  final Controllers controllers;
  final AuthState initialState;

  Future showToast(String msg) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpErrorState) {
          showToast(state.message);
        } else if (state is SignInErrorState) {
          showToast(state.message);
        } else if (state is SignedUpState) {
          showToast('new account has been registered');
        } else if (state is SignedUpState) {
          showToast('welcome');
        }
      },
      builder: (context, state) {
        // return const CompanySelect();
        if (state is AuthInitial) {
          return const Authenticate();
        } else if (state is SigningInState) {
          return LogIn(
            controllers: controllers,
          );
        } else if (state is SignedInState) {
          controllers.tecEmailLogIn.text = '';
          controllers.tecPassLogIn.text = '';
          return const CompanySelect();
        } else if (state is SignInErrorState) {
          return LogIn(
            controllers: controllers,
            // hasPopup: true,
            // popupWidget: Popup(),
          );
        } else if (state is SigningUpState) {
          return SignUp(
            controllers: controllers,
          );
        } else if (state is SignedUpState) {
          return const CompanySelect();
        } else if (state is SignUpErrorState) {
          return SignUp(
            controllers: controllers,
            // hasPopup: true,
            // popupWidget: Popup(),
          );
        } else if (state is Loading) {
          return Scaffold(
            body: Center(
              child: SpinKitFoldingCube(
                color: Theme.of(context).primaryColor,
                size: 120,
              ),
            ),
          );
        } else {
          return const Text('unexpected state!');
        }
      },
    );
  }
}
