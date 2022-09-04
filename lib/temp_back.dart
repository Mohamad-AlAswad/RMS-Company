import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rms_company/data/repositories/job/job_repo_imp.dart';
import 'package:rms_company/domain/entities/entities.dart';
import 'package:rms_company/domain/entities/job/description_field/description_field.dart';
import 'package:rms_company/domain/usecases/job/add_new_job.dart';
import 'package:rms_company/domain/usecases/job/pause_status_job.dart';
import 'package:rms_company/domain/usecases/job/remove_job.dart';
import 'package:rms_company/domain/usecases/job/resume_status_job.dart';
import 'domain/usecases/autocomplete/autocomplete_degrees.dart';
import 'domain/usecases/autocomplete/autocomplete_field_edu.dart';
import 'domain/usecases/autocomplete/autocomplete_job_titles.dart';
import 'domain/usecases/autocomplete/autocomplete_languages.dart';
import 'domain/usecases/autocomplete/autocomplete_skills.dart';
import 'domain/usecases/autocomplete/autocomplete_universities.dart';
import 'domain/usecases/job/fetch_more.dart';
import 'domain/usecases/user/get_profile_user.dart';
import 'domain/entities/user/user_info.dart' as user_info;
import 'domain/usecases/user/update_profile_user.dart';
import 'injection_container.dart';

class Temp {
  void getJob({required String id}) async {
    print('before');

    Job job = Job(
      id: 'id',
      title: 'ai software developer',
      summary: 'useless4656456456456456456465465465 summary2',
      publishedTime: Timestamp.now(),
      skills: const [
        SkillDescriptionField(title: 'r', isRequired: true),
        SkillDescriptionField(title: 'powershell', isRequired: true),
        SkillDescriptionField(title: 'photoshop', isRequired: true),
        SkillDescriptionField(title: 'mongodb', isRequired: false),
      ],
      eduQualifications: const [],
      experiences: const [],
      languages: const [],
      status: 'running',
    );
    AddNewJob addNewJob = AddNewJob();
    print('middle');
    try {
      print('try');
      var x = await FirebaseFirestore.instance
          .collection('jobs')
          .add({'Fuck': 'IT'});
      print(x);
    } catch (e) {
      print('catch');

      print(e);
    }
    addNewJob(job: job);
    print('after');
  }

  void updateUser() {
    user_info.UserInfo userInfo = const user_info.UserInfo(
      email: 'don\'t use this email',
      firstName: 'first name',
      middleName: 'middle name',
      lastName: 'last name',
      imgUrl: '',
      gender: 'Male',
      nationality: 'Syrian',
      location: 'Syria',
      phones: [],
      emails: [],
    );
    UpdateProfileUser updateProfileUser = UpdateProfileUser();
    updateProfileUser(newUserInfo: userInfo);
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  @override
  Widget build(BuildContext context) {
    // Temp().getJob(id: 's');
    RemoveJob removeJob = RemoveJob();
    AddNewJob addNewJob = AddNewJob();
    PauseStatusJob pauseJob = PauseStatusJob();
    ResumeStatusJob resumeJob = ResumeStatusJob();

    removeJob(jobId: '2NrGALiQwBR2jFCs2kwV');

    GetProfileUser getProfileUser = sl();
    FetchMoreJob fetchMoreJob = FetchMoreJob();
    Job? googleJob;

    String? curr = 'sk';
    String word = 'java';
    int? limit;
    bool? exact;
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextButton(
                  child: const Text('fetch more jobs'),
                  onPressed: () async {
                    var res = await fetchMoreJob(limit: 10);
                    res.forEach((element) {
                      print(element.summary);
                      resumeJob(jobId: element.id);
                    });
                    print('no more data:');
                    print(fetchMoreJob.noMoreData);
                  },
                ),
                TextButton(
                  child: const Text('refresh jobs'),
                  onPressed: () async {
                    fetchMoreJob.refresh();
                  },
                ),
                TextButton(
                  child: const Text('fetch more unavailable'),
                  onPressed: () async {},
                ),
                TextButton(
                  child: const Text('refresh unavailable'),
                  onPressed: () async {},
                ),
                TextButton(
                  child: const Text('get profile info'),
                  onPressed: () async {
                    print(await getProfileUser(
                        userId: 'KWKKUrBFSAPT7sqtP24nqa2gduN2'));
                  },
                ),
                Material(
                  child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'skill',
                        child: Text('skill'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'language',
                        child: Text('language'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'degree',
                        child: Text('degree'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'job-title',
                        child: Text('job-title'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'university',
                        child: Text('university'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Bachelor',
                        child: Text('Bachelor'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Master',
                        child: Text('Master'),
                      ),
                    ],
                    onChanged: (val) {
                      curr = val.toString();
                    },
                  ),
                ),
                Material(
                  child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem<bool>(
                        value: true,
                        child: Text('exact'),
                      ),
                      DropdownMenuItem<bool>(
                        value: false,
                        child: Text('not exact'),
                      ),
                    ],
                    onChanged: (val) {
                      exact = val as bool?;
                    },
                  ),
                ),
                TextButton(
                  child: const Text('get complement'),
                  onPressed: () async {
                    if (curr == 'skill') {
                      print(
                        await AutocompleteSkills()(
                            word: word, limit: limit, exact: exact),
                      );
                    }
                    if (curr == 'language') {
                      print(
                        await AutocompleteLanguages()(
                            word: word, limit: limit, exact: exact),
                      );
                    }
                    if (curr == 'degree') {
                      print(
                        await AutocompleteDegrees()(
                            word: word, limit: limit, exact: exact),
                      );
                    }
                    if (curr == 'job-title') {
                      print(
                        await AutocompleteJobTitles()(
                            word: word, limit: limit, exact: exact),
                      );
                    }
                    if (curr == 'university') {
                      print(
                        await AutocompleteUniversities()(
                            word: word, limit: limit, exact: exact),
                      );
                    }

                    if (curr == 'Bachelor') {
                      print(
                        await AutocompleteFieldEdu()(
                            degree: 'Bachelor',
                            word: word,
                            limit: limit,
                            exact: exact),
                      );
                    }
                    if (curr == 'Master') {
                      print(
                        await AutocompleteFieldEdu()(
                            degree: 'Master',
                            word: word,
                            limit: limit,
                            exact: exact),
                      );
                    }
                  },
                ),
                Material(
                  child: TextFormField(
                    onChanged: (val) {
                      word = val.toString();
                    },
                  ),
                ),
                Material(
                  child: TextFormField(
                    onChanged: (val) {
                      limit = 2;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
