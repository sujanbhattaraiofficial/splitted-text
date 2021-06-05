import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_split/constant.dart';
import 'package:page_split/logic/dyamicSize.dart';
import 'package:page_split/logic/splittedText.dart';

class PageControlBloc extends Cubit<int> {
  PageControlBloc() : super(0);

  DynamicSize _dynamicSize = DynamicSizeImpl();
  SplittedText _splittedText = SplittedTextImpl();
  Size _size;
  List<String> _splittedTextList = [];
  List<String> get splittedTextList => _splittedTextList;

  getSizeFromBloc(GlobalKey pagekey) {
    _size = _dynamicSize.getSize(pagekey);
    print(_size);
  }

  getSplittedTextFromBloc(TextStyle textStyle) {
    _splittedTextList =
        _splittedText.getSplittedText(_size, textStyle, kSmapleText);
  }

  void changeState(int currentIndex) {
    emit(currentIndex);
  }
}
