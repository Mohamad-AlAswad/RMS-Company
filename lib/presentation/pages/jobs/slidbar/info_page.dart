import 'package:flutter/material.dart';

import '../../../../domain/entities/job/job.dart';
import '../../../components/components.dart';
import '../../../controllers/controllers.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.job}) : super(key: key);
  final Job job;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late Job job;
  TextEditingController titleController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  late String value;
  List<Pair> eduControllers = [];
  List<Pair> expControllers = [];
  List<Pair> skillControllers = [];
  List<Pair> langControllers = [];

  @override
  void initState() {
    super.initState();
    job = widget.job;
    value = job.status;
    titleController.text = job.title;
    summaryController.text = job.summary;
    eduControllers.addAll(job.eduQualifications.map(
      (e) {
        EduControllers edu = EduControllers();
        edu.degree.text = e.degree;
        edu.certificateName.text = e.field;
        return Pair(edu, e.isRequired);
      },
    ).toList());
    expControllers.addAll(job.experiences.map(
      (e) {
        ExpControllers exp = ExpControllers();
        exp.title.text = e.title;
        exp.duration.text = e.period.toString();
        return Pair(exp, e.isRequired);
      },
    ).toList());
    skillControllers.addAll(job.skills.map(
      (e) {
        SkillsControllers skill = SkillsControllers();
        skill.title.text = e.title;
        return Pair(skill, e.isRequired);
      },
    ).toList());
    langControllers.addAll(job.languages.map(
      (e) {
        LanguagesControllers lang = LanguagesControllers();
        lang.title.text = e.title;
        return Pair(lang, e.isRequired);
      },
    ).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: ListView(
        children: [
          TitleBuilder(titleController: titleController),
          SummaryBuilder(summaryController: summaryController),
          Padding(
            padding: const EdgeInsets.all(10),
            child: RoundedDropdownButton(
              list: const ['running', 'paused'],
              valueChanged: (val) {
                setState(() {
                  value = val;
                });
              },
              enabled: false,
              color: Theme.of(context).primaryColor,
              label: 'Status',
              icon: Icons.pause,
              value: job.status,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Educational Certificate :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                if (eduControllers.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      'No Educational Certificates Specified !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: eduControllers.length,
                  itemBuilder: (context, index) => EduQualificationItem(
                    eduControllers: eduControllers[index].left,
                    enabled: false,
                    index: index,
                    certificateNames: const [],
                    degrees: const [],
                    delete: (idx) {},
                    short: true,
                    sp: true,
                    required: (val) {},
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Past Experience :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                if (expControllers.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      'No Experiences Specified !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: expControllers.length,
                  itemBuilder: (context, index) => PastExperienceItem(
                    expController: expControllers[index].left,
                    enabled: false,
                    index: index,
                    titles: const [],
                    delete: (idx) {},
                    short: true,
                    sp: true,
                    required: (bool value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Skills :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                if (skillControllers.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      'No Skills Specified !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: skillControllers.length,
                  itemBuilder: (context, index) => SkillItem(
                    skillsController: skillControllers[index].left,
                    enabled: false,
                    index: index,
                    titles: const [],
                    delete: (idx) {},
                    short: true,
                    sp: true,
                    required: (bool value) {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Languages :',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                if (langControllers.isEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Text(
                      'No Languages Specified !',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
                ListView.separated(
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10),
                  shrinkWrap: true,
                  primary: false,
                  itemCount: langControllers.length,
                  itemBuilder: (context, index) => LanguageItem(
                    languagesController: langControllers[index].left,
                    enabled: false,
                    titles: const [],
                    index: index,
                    delete: (idx) {},
                    short: true,
                    sp: true,
                    required: (bool value) {},
                  ),
                ),
              ],
            ),
          ),
          const Text('Im ques'),

        ],
      ),
    );
  }
}

class SummaryBuilder extends StatelessWidget {
  const SummaryBuilder({
    Key? key,
    required this.summaryController,
  }) : super(key: key);

  final TextEditingController summaryController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RoundedTextField(
        enabled: false,
        controller: summaryController,
        color: Theme.of(context).primaryColor,
        label: 'Summary',
        icon: Icons.text_snippet_outlined,
        multiLines: true,
      ),
    );
  }
}

class TitleBuilder extends StatelessWidget {
  const TitleBuilder({
    Key? key,
    required this.titleController,
  }) : super(key: key);

  final TextEditingController titleController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: RoundedTextField(
        enabled: false,
        controller: titleController,
        color: Theme.of(context).primaryColor,
        label: 'Title',
        icon: Icons.title_outlined,
      ),
    );
  }
}

class Pair {
  Pair(this.left, this.right);

  dynamic left;
  dynamic right;

  @override
  String toString() => 'Pair[$left, $right]';
}
