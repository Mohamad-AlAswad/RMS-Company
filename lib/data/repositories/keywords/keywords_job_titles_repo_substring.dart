import '../../../domain/repositories/keywords/keywords_job_titles_repo.dart';
import 'keywords_repo_substring.dart';

class KeywordsJobTitlesRepoSubstring implements KeywordsJobTitlesRepo {
  final KeywordsRepoSubstring keywordsRepoSubstring;

  @override
  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  }) {
    return keywordsRepoSubstring.getSimilar(
      word: word,
      limit: limit,
      exact: exact,
    );
  }

  KeywordsJobTitlesRepoSubstring()
      : keywordsRepoSubstring = KeywordsRepoSubstring(type: 'job-title');
}
