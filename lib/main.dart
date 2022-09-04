import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:rms_company/provider/update_action_bar_actions_notification.dart';
import 'domain/repositories/authentication_repo.dart';
import 'injection_container.dart';
import 'temp_back.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'data/repositories/authentication_repo.dart';
import 'domain/usecases/authentication/get_connected_user.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'presentation/blocs/authentication/auth_bloc.dart';
import 'presentation/wrapper.dart';
import 'presentation/controllers/controllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();

  // runApp(const MyApp2());
  runApp(
    Phoenix(
      child: ChangeNotifierProvider(
        create: (_) => UpdateActionBarActions(),
        child: MyApp(),
      ),
    ),
  );
}

//
class MyApp extends StatelessWidget {
  late final AuthenticationRepo authenticationUsingTwoSteps;
  late final AuthBloc authBloc;
  late final GetConnectedUser getConnectedUser;
  final Controllers controllers = Controllers();

  //
  MyApp({Key? key}) : super(key: key) {
    authenticationUsingTwoSteps = sl();

    authBloc = AuthBloc(
      signUpEmailPassword: SignUpEmailPassword(),
      signInEmailAndPassword: SignInEmailAndPassword(),
      logOut: LogOut(),
      initialState: FirebaseAuth.instance.currentUser == null
          ? AuthInitial()
          : const SignedInState(),
    );

    getConnectedUser = sl();
  }

  @override
  Widget build(BuildContext context) {
    return Wrapper(
      authBloc: authBloc,
      controllers: controllers,
    );
  }
}
