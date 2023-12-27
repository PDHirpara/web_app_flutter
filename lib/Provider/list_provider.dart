import 'package:flutter/cupertino.dart';

class list_book extends ChangeNotifier {
  List bookmark = [];

  add_mark(Url) {
    bookmark.add(Url);
    notifyListeners();
  }

  remove_marl(Url) {
    bookmark.remove(Url);
    notifyListeners();
  }


}
