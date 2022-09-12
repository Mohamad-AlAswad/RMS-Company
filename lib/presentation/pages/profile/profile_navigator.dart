import 'package:flutter/material.dart';

import '../../controllers/controllers.dart';
import 'tabs/tabs.dart';

class ProfileNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorState;
  final String tabItem;
  final UserController userController;


  const ProfileNavigator({
    Key? key,
    required this.navigatorState,
    required this.tabItem,
    required this.userController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (tabItem) {
      case 'personal':
        child = PersonalInformation(personalControllers: userController.personalControllers,);
        break;
      case 'edu':
        child = const EducationalQualifications();
        break;
      case 'exp':
        child = const PastExperiences();
        break;
      case 'skills':
        child = const Skills();
        break;
      case 'lang':
        child = const Languages();
        break;
      case 'company':
        child = CompanyInformation(companyController: userController.companyController,);
        break;
      default:
        child = const ErrorPage();
        break;
    }
    return Navigator(
      key: navigatorState,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('error'),
    );
  }
}
