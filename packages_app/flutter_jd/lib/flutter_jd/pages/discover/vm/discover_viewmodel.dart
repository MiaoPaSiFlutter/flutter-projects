import 'package:flutter_jd/flutter_jd.dart';

class DiscoverViewModel extends ScreenViewModel {
  int selectIndex = 1;

  DiscoverViewModel({String? functionId}) {
    // _functionId = functionId;
  }

  Future<void> getPageDatas() async {
    state = ScreenState.CONTENT;
    notifyListeners();
  }

  void updateCVS({int? selectIndex_}) {
    if (selectIndex_ != null) {
      selectIndex = selectIndex_;
    }
    notifyListeners();
  }
}
