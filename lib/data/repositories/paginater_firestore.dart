import 'package:cloud_firestore/cloud_firestore.dart';

class PaginaterFirestore {
  final Query query;
  bool _lazy = true;
  bool _noMoreData = false;
  QueryDocumentSnapshot? _last;
  QueryDocumentSnapshot? _tempLast;

  PaginaterFirestore({required this.query});

  Future<QuerySnapshot<Object?>?> fetch({required int limit}) async {
    if (noMoreData == true) return Future.value(null);
    if (_lazy == true) {
      _last = null;
      _tempLast = null;
      _noMoreData = false;
    }
    _lazy = false;
    Query pagQuery = query.limit(limit);
    if (_last != null) pagQuery = pagQuery.startAfterDocument(_last!);
    var response = await pagQuery.get();
    if (response.docs.length < limit) {
      _noMoreData = true;
      _tempLast = null;
    } else {
      _tempLast = response.docs[response.docs.length - 1];
    }
    return Future.value(response);
  }

  void commitFetching() => _last = _tempLast;

  bool get noMoreData => _noMoreData;

  void refresh() => _lazy = true;
}
