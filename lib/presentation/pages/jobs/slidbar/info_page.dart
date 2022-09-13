import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms_company/domain/usecases/job/reply_inquiry.dart';

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
  List<bool> answers = [];
  List<Pair?> answersVal = [];

  @override
  void initState() {
    super.initState();
    job = widget.job;
    answers = job.inquiries.map((e) => e.answer != null).toList();
    answersVal = job.inquiries.map((e) {
      if (e.answer != null) {
        return Pair(e.answer, e.answerDate);
      }
    }).toList();
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
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Inquiries :',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(
                                job.inquiries[index].inquiryDate.toDate()),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        job.inquiries[index].inquiry,
                        style: const TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      if (job.inquiries[index].answer != null ||
                          answers[index]) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(
                                (job.inquiries[index].answer != null)
                                    ? job.inquiries[index].answerDate!.toDate()
                                    : answersVal[index]!.right,
                              ),
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          (job.inquiries[index].answer != null)
                              ? job.inquiries[index].answer!
                              : answersVal[index]!.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                      if (!answers[index] &&
                          job.inquiries[index].answer == null) ...[
                        RoundedTextField(
                          controller: TextEditingController(),
                          color: Theme.of(context).primaryColor,
                          enabled: true,
                          w: 0.85,
                          icon: Icons.question_answer_outlined,
                          label: 'Answer',
                          suffixText: 'save',
                          suffixPress: (val) {
                            ReplyInquiry()(
                              job: job,
                              answer: val,
                              inquiryJob: job.inquiries[index],
                            ).then((value) {
                              setState(() {
                                answers[index] = true;
                                if (answersVal[index] == null) {
                                  answersVal[index] = Pair(val, DateTime.now());
                                }
                              });
                            });
                          },
                          multiLines: true,
                        ),
                      ],
                    ],
                  )),
            ),
            itemCount: job.inquiries.length,
            separatorBuilder: (context, index) => Column(
              children: [
                const SizedBox(height: 10),
                Divider(
                  color: Theme.of(context).primaryColor,
                  indent: 30,
                  endIndent: 40,
                  thickness: 2,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
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
