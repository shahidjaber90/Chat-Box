import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {
  bool isSearch = false;
  bool isLoading = false;

  void isSearching() {
    isSearch = !isSearch;
    notifyListeners();
  }

  void onSearch(Map<String, dynamic> userMap, controller) async {
    isLoading = true;
    notifyListeners();
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('Users')
        .where('email', isEqualTo: controller)
        .get()
        .then((value) {
      userMap = value.docs[0].data();
      isLoading = false;
      notifyListeners();
    });
    print('on search data:: $userMap');
  }
}
