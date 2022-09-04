import '../../../injection_container.dart';
import '../../datasources/remote/autocomplete_substring_api.dart';

class KeywordsRepoSubstring {
  final AutocompleteSubstringApi autocompleteSubstringApi;
  final String type;

  KeywordsRepoSubstring({
    required this.type,
  }) : autocompleteSubstringApi = sl();

  Future<List<String>> getSimilar({
    required String word,
    int? limit,
    bool? exact,
  }) async {
    return autocompleteSubstringApi.getSimilar(
      type: type,
      word: word,
      limit: limit,
      exact: exact,
    );
  }
}
