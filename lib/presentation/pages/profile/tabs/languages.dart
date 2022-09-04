import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/update_action_bar_actions_notification.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';

class Languages extends StatefulWidget {
  const Languages({
    Key? key,
  }) : super(key: key);

  @override
  State<Languages> createState() => _LanguagesState();
}

class _LanguagesState extends State<Languages> {
  late bool isLoading;
  late List<String> titles;
  late bool enabled;
  List<LanguagesControllers> languagesControllers = [];

  Future fetchData() async {
    setState(() {
      isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
    titles = [
      'languages1',
      'languages2',
      'languages3',
      'languages4',
      'languages5',
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    enabled = Provider.of<UpdateActionBarActions>(context).edit;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          child: ListView(
            children: [
              if (enabled) ...[
                MyElevatedButton(
                  text: 'Add a Language',
                  press: () {
                    setState(() {
                      languagesControllers.insert(
                        languagesControllers.length,
                        LanguagesControllers(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
              if (languagesControllers.isNotEmpty) ...[
                ListView.separated(
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 15)),
                  itemBuilder: (context, index) => LanguageItem(
                    languagesController: languagesControllers[index],
                    enabled: enabled,
                    titles: titles,
                    index: index,
                    delete: (idx) {
                      setState(() {
                        languagesControllers.removeAt(idx);
                      });
                    },
                  ),
                  itemCount: languagesControllers.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 120),
              ],
              if (languagesControllers.isEmpty) ...[
                const SizedBox(height: 100),
                Image.asset('assets/png/Asset 2.png', height: 200),
                const SizedBox(height: 50),
                const Center(
                  child: ListTile(
                    title: Text(
                      'No Languages',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'please add some Languages to show them',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
