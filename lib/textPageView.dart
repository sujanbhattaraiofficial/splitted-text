import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/pageControlBloc.dart';
import 'constant.dart';

class TextPageView extends StatefulWidget {
  const TextPageView({Key key}) : super(key: key);

  @override
  _TextPageViewState createState() => _TextPageViewState();
}

class _TextPageViewState extends State<TextPageView> {
  final GlobalKey pageKey = GlobalKey();
  final PageController _pageController = PageController();
  final TextStyle _textStyle = TextStyle(color: Colors.black, fontSize: 25);

  @override
  void initState() {
    super.initState();
    final controlBloc = BlocProvider.of<PageControlBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controlBloc.getSizeFromBloc(pageKey);
      controlBloc.getSplittedTextFromBloc(_textStyle);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final controlBloc = BlocProvider.of<PageControlBloc>(context);
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.yellowAccent.withOpacity(0.2),
            key: pageKey,
            child: PageView.builder(
                controller: _pageController,
                onPageChanged: (val) {
                  controlBloc.changeState(val);
                },
                itemCount: controlBloc.splittedTextList.length,
                itemBuilder: (context, index) {
                  return Text(
                    controlBloc.splittedTextList[index],
                    style: _textStyle,
                  );
                }),
          ),
        ),
        _pageControll()
      ],
    );
  }

  Widget _pageControll() {
    return BlocBuilder<PageControlBloc, int>(
      builder: (context, state) {
        final int _length =
            BlocProvider.of<PageControlBloc>(context).splittedTextList.length;
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Icon(Icons.first_page),
                  onPressed: () {
                    _pageController.animateToPage(0,
                        duration: kDuration, curve: kCurve);
                  }),
              IconButton(
                icon: Icon(Icons.navigate_before),
                onPressed: () {
                  _pageController.previousPage(
                      duration: kDuration, curve: kCurve);
                },
              ),
              Text(
                '${state + 1}/$_length',
              ),
              IconButton(
                icon: Icon(Icons.navigate_next),
                onPressed: () {
                  _pageController.nextPage(duration: kDuration, curve: kCurve);
                },
              ),
              IconButton(
                icon: Icon(Icons.last_page),
                onPressed: () {
                  _pageController.animateToPage(_length,
                      duration: kDuration, curve: kCurve);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
