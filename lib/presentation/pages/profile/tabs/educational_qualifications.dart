import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/update_action_bar_actions_notification.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';

class EducationalQualifications extends StatefulWidget {
  const EducationalQualifications({
    Key? key,
  }) : super(key: key);

  @override
  State<EducationalQualifications> createState() =>
      _EducationalQualificationsState();
}

class _EducationalQualificationsState extends State<EducationalQualifications> {
  late bool isLoading;
  late List<String> certificateNames;
  late List<String> degrees;
  late List<DateTime?> dates;
  late bool enabled;
  List<EduControllers> eduControllers = [];

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
                  text: 'Add a Certificate',
                  press: () {
                    setState(() {
                      eduControllers.insert(
                        eduControllers.length,
                        EduControllers(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
              if (eduControllers.isNotEmpty) ...[
                ListView.separated(
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 30)),
                  itemBuilder: (context, index) => EduQualificationItem(
                    eduControllers: eduControllers[index],
                    enabled: enabled,
                    certificateNames: certificateNames,
                    degrees: degrees,
                    index: index,
                    delete: (idx) {
                      setState(() {
                        eduControllers.removeAt(idx);
                      });
                    },
                  ),
                  itemCount: eduControllers.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 120),
              ],
              if (eduControllers.isEmpty) ...[
                const SizedBox(height: 100),
                Image.asset('assets/png/Asset 2.png', height: 200),
                const SizedBox(height: 50),
                const Center(
                  child: ListTile(
                    title: Text(
                      'No Educational Certificate',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'please add some Certificate to show them',
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

