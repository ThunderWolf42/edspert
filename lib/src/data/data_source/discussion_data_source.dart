import 'package:cloud_firestore/cloud_firestore.dart';


import '../models/discussion_model.dart';

class DiscussionDataSource {
  static const String discussionPath = 'Discussions';

  Future<void> createDiscussion(DiscussionModel discussionModel) async {
    String newDocumentId = _createUniqueId();
    await FirebaseFirestore.instance
        .doc('$discussionPath/$newDocumentId')
        .set(discussionModel.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamDiscussion() {
    return FirebaseFirestore.instance.collection(discussionPath).snapshots();
  }

  String _createUniqueId() {
    return DateTime.now().microsecondsSinceEpoch.toString();
  }
}