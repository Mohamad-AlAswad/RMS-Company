import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/update_action_bar_actions_notification.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';

class PastExperiences extends StatefulWidget {
  const PastExperiences({
    Key? key,
  }) : super(key: key);

  @override
  State<PastExperiences> createState() => _PastExperiencesState();
}

class _PastExperiencesState extends State<PastExperiences> {
  late bool isLoading;
  late List<String> titles;
  late List<DateTime?> dates;
  late List<double> durations;
  late bool enabled;
  List<ExpControllers> expControllers = [];

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
      'title1',
      'title2',
      'title3',
      'title5',
      'title4',
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
                  text: 'Add an Experience',
                  press: () {
                    setState(() {
                      expControllers.insert(
                        expControllers.length,
                        ExpControllers(),
                      );
                    });
                  },
                ),
                const SizedBox(height: 20),
              ],
              if (expControllers.isNotEmpty) ...[
                ListView.separated(
                  separatorBuilder: ((context, index) =>
                      const SizedBox(height: 30)),
                  itemBuilder: (context, index) => PastExperienceItem(
                    expController: expControllers[index],
                    enabled: enabled,
                    titles: titles,
                    index: index,
                    delete: (idx) {
                      setState(() {
                        expControllers.removeAt(idx);
                      });
                    },
                  ),
                  itemCount: expControllers.length,
                  shrinkWrap: true,
                  primary: false,
                ),
                const SizedBox(height: 120),
              ],
              if (expControllers.isEmpty) ...[
                const SizedBox(height: 100),
                Image.asset('assets/png/Asset 2.png', height: 200),
                const SizedBox(height: 50),
                const Center(
                  child: ListTile(
                    title: Text(
                      'No Past Experiences',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'please add some Past Experiences to show them',
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
