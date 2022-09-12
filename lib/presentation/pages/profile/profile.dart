import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rms_company/domain/usecases/%20company/update_company.dart';
import 'package:rms_company/presentation/controllers/controllers.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/authentication/get_connected_user.dart';
import '../../../domain/usecases/user/update_profile_user.dart';
import '../../../provider/update_action_bar_actions_notification.dart';
import '../../components/components.dart';
import 'profile_navigator.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int currentIndex = 0;
  late bool isLoading;
  String currentPage = 'personal';
  UserController userController =
      TransformerUserController.fromUserInfo(GetConnectedUser().connectedUser);
  List<String> pagesKeys = [
    'personal', 'company'
    // 'edu', 'exp', 'skills', 'lang'
  ];
  Map<String, GlobalKey<NavigatorState>> navigatorState = {
    'personal': GlobalKey<NavigatorState>(),
    'edu': GlobalKey<NavigatorState>(),
    'exp': GlobalKey<NavigatorState>(),
    'skills': GlobalKey<NavigatorState>(),
    'lang': GlobalKey<NavigatorState>(),
    'company': GlobalKey<NavigatorState>(),
  };

  late UpdateProfileUser updateProfileUser;
  late UpdateCompany updateCompany;

  saveChanges() async {
    setState(() {
      isLoading = true;
    });
    UserInfo userInfo =
        TransformerUserController.fromUserController(userController);
    Company company = TransformerUserController.fromController(userController);

    PersonalControllers? newPerController;
    CompanyController? newCompController;
    await updateProfileUser(newUserInfo: userInfo).then((value) {
      newPerController = TransformerUserController.fromUserInfo(
              GetConnectedUser().connectedUser)
          .personalControllers;
    }).timeout(const Duration(seconds: 5),onTimeout: (){
        isLoading = false;
        Fluttertoast.cancel();
        Fluttertoast.showToast(msg: 'Connection Error');
    });

    await updateCompany(newCompany: company).then((value) {
      newCompController = TransformerUserController.fromUserInfo(
              GetConnectedUser().connectedUser)
          .companyController;
    }).timeout(const Duration(seconds: 5),onTimeout: (){
      isLoading = false;
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Connection Error');
    });

    setState(() {
      if (newPerController != null && newCompController != null) {
        userController = UserController(
          personalControllers: newPerController!,
          companyController: newCompController!,
        );
      }
      isLoading = false;
    });

    // ignore: use_build_context_synchronously
    Provider.of<UpdateActionBarActions>(context, listen: false)
        .changeEditMode(false);
  }

  final List<Text> texts = [
    const Text('Personal Information', style: TextStyle(fontSize: 20)),
    const Text('Company Information', style: TextStyle(fontSize: 20)),
  ];
  late List<Widget> actions1;
  late List<Widget> actions2;

  @override
  void initState() {
    super.initState();
    updateProfileUser = UpdateProfileUser();
    updateCompany = UpdateCompany();
    isLoading = false;
    actions2 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 30,
          ),
          onPressed: () {
            Provider.of<UpdateActionBarActions>(context, listen: false)
                .changeEditMode(true);
          },
        ),
      ),
    ];
    actions1 = [
      Padding(
        padding: const EdgeInsets.only(right: 10),
        child: IconButton(
          icon: const Icon(
            Icons.published_with_changes_outlined,
            size: 30,
          ),
          onPressed: saveChanges,
        ),
      ),
    ];
  }

  void selectTab(int index) {
    if (currentPage == pagesKeys[index]) {
      navigatorState[index]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        currentPage = pagesKeys[index];
        currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        initialIndex: currentIndex,
        length: pagesKeys.length,
        child: WillPopScope(
          onWillPop: () async {
            final isFirstRouteInCurrentTab =
                !await navigatorState[currentPage]!.currentState!.maybePop();
            if (isFirstRouteInCurrentTab) {
              if (currentPage != 'personal') {
                selectTab(1);
              }
              if (currentPage != 'company') {
                selectTab(2);
              }
            }
            return isFirstRouteInCurrentTab;
          },
          child: Scaffold(
            appBar: CustomeAppBar(
              label: 'Profile',
              actions1: actions1,
              actions2: actions2,
            ),
            body: Scaffold(
              appBar: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                isScrollable: true,
                // padding: const EdgeInsets.only(top: 10),
                onTap: (value) => selectTab(value),
                tabs: texts,
              ),
              body: (isLoading)
                  ? Center(
                      child: SpinKitFoldingCube(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : Stack(
                      children: pagesKeys
                          .map(
                            (e) => buildOffstageNavigator(e),
                          )
                          .toList(),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: ProfileNavigator(
        navigatorState: navigatorState[tabItem]!,
        tabItem: tabItem,
        userController: userController,
      ),
    );
  }
}
