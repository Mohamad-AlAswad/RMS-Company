import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:rms_company/domain/repositories/job/job_repo.dart';
import 'data/datasources/remote/autocomplete_substring_api.dart';
import 'data/datasources/remote/evaluator_api.dart';
import 'data/datasources/remote/firebase_authentication.dart';
import 'data/repositories/authentication_repo.dart';
import 'data/repositories/job/job_repo_imp.dart';
import 'data/repositories/keywords/keywords_degree_edu_repo_substring.dart';
import 'data/repositories/keywords/keywords_field_edu_repo_substring.dart';
import 'data/repositories/keywords/keywords_job_titles_repo_substring.dart';
import 'data/repositories/keywords/keywords_languages_repo_substring.dart';
import 'data/repositories/keywords/keywords_skills_repo_substring.dart';
import 'data/repositories/keywords/keywords_universities_repo_substring.dart';
import 'data/repositories/user_info_repo_imp.dart';
import 'domain/repositories/authentication_repo.dart';
import 'domain/repositories/keywords/keywords_degree_edu_repo.dart';
import 'domain/repositories/keywords/keywords_field_edu_repo.dart';
import 'domain/repositories/keywords/keywords_job_titles_repo.dart';
import 'domain/repositories/keywords/keywords_languages_repo.dart';
import 'domain/repositories/keywords/keywords_skills_repo.dart';
import 'domain/repositories/keywords/keywords_universities_repo.dart';
import 'domain/repositories/user_info_repo.dart';
import 'domain/usecases/authentication/connected_company_user.dart';
import 'domain/usecases/authentication/get_connected_user.dart';
import 'domain/usecases/authentication/log_out.dart';
import 'domain/usecases/authentication/sign_in_email_password.dart';
import 'domain/usecases/authentication/sign_up_email_password.dart';
import 'domain/usecases/autocomplete/autocomplete_degrees.dart';
import 'domain/usecases/autocomplete/autocomplete_field_edu.dart';
import 'domain/usecases/autocomplete/autocomplete_job_titles.dart';
import 'domain/usecases/autocomplete/autocomplete_languages.dart';
import 'domain/usecases/autocomplete/autocomplete_skills.dart';
import 'domain/usecases/autocomplete/autocomplete_universities.dart';
import 'domain/usecases/job/add_new_job.dart';
import 'domain/usecases/job/applied/accept_applied.dart';
import 'domain/usecases/job/applied/get_detailed.dart';
import 'domain/usecases/job/applied/rate_application.dart';
import 'domain/usecases/job/applied/reject_applied.dart';
import 'domain/usecases/job/fetch_more.dart';
import 'domain/usecases/job/pause_status_job.dart';
import 'domain/usecases/job/remove_job.dart';
import 'domain/usecases/job/resume_status_job.dart';
import 'domain/usecases/job_seeker/get_profile_job_seeker.dart';
import 'domain/usecases/user/get_profile_user.dart';
import 'domain/usecases/user/update_profile_user.dart';

final sl = GetIt.instance;

void init() {
  initData();
  initUseCases();
}

void initData() {
  //
  //
  // datasources
  sl.registerSingleton(FirebaseFirestore.instance);
  sl.registerSingleton(FirebaseAuth.instance);
  sl.registerLazySingleton<EvaluatorApi>(() => EvaluatorApiImp());
  sl.registerLazySingleton<UserInfoRepo>(
    () => UserInfoRepoImp(firebaseFirestore: sl()),
  );
  sl.registerLazySingleton<AuthenticationRemote>(
    () => FirebaseAuthentication(userInfoRepo: sl()),
  );
  sl.registerLazySingleton<AutocompleteSubstringApi>(
    () => AutocompleteSubstringApiImp(),
  );
  //
  //
  // repositories
  sl.registerLazySingleton<AuthenticationRepo>(
    () => AuthenticationUsingTwoSteps(),
  );
  sl.registerLazySingleton<JobRepo>(
    () => JobRepoImp(),
  );

  sl.registerLazySingleton<KeywordsSkillsRepo>(
    () => KeywordsSkillsRepoSubstring(),
  );
  sl.registerLazySingleton<KeywordsLanguagesRepo>(
    () => KeywordsLanguagesRepoSubstring(),
  );
  sl.registerLazySingleton<KeywordsFieldEduRepo>(
    () => KeywordsFieldEduRepoSubstring(),
  );
  sl.registerLazySingleton<KeywordsDegreeEduRepo>(
    () => KeywordsDegreeEduRepoSubstring(),
  );
  sl.registerLazySingleton<KeywordsJobTitlesRepo>(
    () => KeywordsJobTitlesRepoSubstring(),
  );
  sl.registerLazySingleton<KeywordsUniversitiesRepo>(
    () => KeywordsUniversitiesRepoSubstring(),
  );
}

void initUseCases() {
  // authentication
  sl.registerLazySingleton(() => GetConnectedUser());
  sl.registerLazySingleton(() => ConnectedCompanyUser());
  sl.registerLazySingleton(() => LogOut());
  sl.registerLazySingleton(() => SignInEmailAndPassword());
  sl.registerLazySingleton(() => SignUpEmailPassword());
  // autocomplete
  sl.registerLazySingleton(() => AutocompleteDegrees());
  sl.registerLazySingleton(() => AutocompleteFieldEdu());
  sl.registerLazySingleton(() => AutocompleteJobTitles());
  sl.registerLazySingleton(() => AutocompleteLanguages());
  sl.registerLazySingleton(() => AutocompleteSkills());
  sl.registerLazySingleton(() => AutocompleteUniversities());
  // job - applied
  sl.registerLazySingleton(() => AcceptApplied());
  sl.registerLazySingleton(() => GetDetailedApplied());
  sl.registerLazySingleton(() => RateApplication());
  sl.registerLazySingleton(() => RejectApplied());
  // job
  sl.registerLazySingleton(() => AddNewJob());
  sl.registerLazySingleton(() => FetchMoreJob());
  sl.registerLazySingleton(() => PauseStatusJob());
  sl.registerLazySingleton(() => RemoveJob());
  sl.registerLazySingleton(() => ResumeStatusJob());
  // job seeker
  sl.registerLazySingleton(() => GetProfileJobSeeker());
  // user
  sl.registerSingleton(GetProfileUser());
  sl.registerSingleton(UpdateProfileUser());
}
