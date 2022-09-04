import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rms_company/domain/entities/job/description_field/description_field.dart';
import 'package:rms_company/presentation/controllers/controllers.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../data/repositories/job/job_repo_imp.dart';
import '../../../domain/entities/job/job.dart';
import '../../../domain/usecases/job/add_new_job.dart';
import '../../../injection_container.dart';
import '../../components/components.dart';

class AddNewJobPage extends StatefulWidget {
  const AddNewJobPage({Key? key}) : super(key: key);

  @override
  State<AddNewJobPage> createState() => _AddNewJobPageState();
}

class _AddNewJobPageState extends State<AddNewJobPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController summaryController = TextEditingController();
  String value = 'running';
  List<Pair> eduControllers = [];
  List<Pair> expControllers = [];
  List<Pair> skillControllers = [];
  List<Pair> langControllers = [];

  save() async {
    Job job = saveJob(
      titleController,
      summaryController,
      value,
      eduControllers,
      expControllers,
      skillControllers,
      langControllers,
    );
    final List<String> err = await AddNewJob()(job: job);
    if (err.isEmpty) {
      await Fluttertoast.cancel();
      Fluttertoast.showToast(
        msg: 'Job Saved Successfully...',
        fontSize: 18,
        // ignore: use_build_context_synchronously
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
      );
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.pop(context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        leading: true,
        label: 'New Job',
        actions: [
          TextButton(
            onPressed: save,
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
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
                enabled: true,
                color: Theme.of(context).primaryColor,
                label: 'Status',
                icon: Icons.pause,
                value: value,
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
                      children: [
                        const Text(
                          'Educational Certificate :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              eduControllers.add(
                                Pair(EduControllers(), false),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: eduControllers.length,
                    itemBuilder: (context, index) => EduQualificationItem(
                      eduControllers: eduControllers[index].left,
                      enabled: true,
                      index: index,
                      certificateNames: const [],
                      degrees: const [],
                      delete: (idx) {
                        setState(() {
                          eduControllers.removeAt(idx);
                        });
                      },
                      short: true,
                      required: (val) {
                        setState(() {
                          eduControllers[index].right = val;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Past Experience :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              expControllers.add(
                                Pair(ExpControllers(), false),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: expControllers.length,
                    itemBuilder: (context, index) => PastExperienceItem(
                      expController: expControllers[index].left,
                      enabled: true,
                      index: index,
                      titles: const [],
                      delete: (idx) {
                        setState(() {
                          expControllers.removeAt(idx);
                        });
                      },
                      short: true,
                      required: (bool value) {
                        setState(() {
                          expControllers[index].right = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Skills :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              skillControllers.add(
                                Pair(SkillsControllers(), false),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: skillControllers.length,
                    itemBuilder: (context, index) => SkillItem(
                      skillsController: skillControllers[index].left,
                      enabled: true,
                      index: index,
                      titles: const [],
                      delete: (idx) {
                        setState(() {
                          skillControllers.removeAt(idx);
                        });
                      },
                      short: true,
                      required: (bool value) {
                        setState(() {
                          skillControllers[index].right = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Languages :',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              langControllers.add(
                                Pair(LanguagesControllers(), false),
                              );
                            });
                          },
                          icon: const Icon(
                            Icons.add_circle,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.separated(
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    shrinkWrap: true,
                    primary: false,
                    itemCount: langControllers.length,
                    itemBuilder: (context, index) => LanguageItem(
                      languagesController: langControllers[index].left,
                      enabled: true,
                      titles: const [],
                      index: index,
                      delete: (idx) {
                        setState(() {
                          langControllers.removeAt(idx);
                        });
                      },
                      short: true,
                      required: (bool value) {
                        setState(() {
                          langControllers[index].right = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
        enabled: true,
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
        enabled: true,
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

Job saveJob(
  TextEditingController titleController,
  TextEditingController summaryController,
  String value,
  List<Pair> eduControllers,
  List<Pair> expControllers,
  List<Pair> skillControllers,
  List<Pair> langControllers,
) {
  Job job = Job(
    id: '',
    title: titleController.text,
    summary: summaryController.text,
    publishedTime: Timestamp.now(),
    skills: skillControllers
        .map((e) => SkillDescriptionField(
            title: e.left.title.text, isRequired: e.right))
        .toList(),
    eduQualifications: eduControllers
        .map((e) => EduQualificationDescriptionField(
            degree: e.left.degree.text,
            field: e.left.certificateName.text,
            isRequired: e.right))
        .toList(),
    experiences: expControllers
        .map((e) => ExperienceDescriptionField(
              title: e.left.title.text,
              period: double.parse(e.left.duration.text),
              isRequired: e.right,
            ))
        .toList(),
    languages: langControllers
        .map((e) => LanguageDescriptionField(
            title: e.left.title.text, isRequired: e.right))
        .toList(),
    status: value,
  );
  return job;
}
