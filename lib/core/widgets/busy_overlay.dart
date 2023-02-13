import 'dart:ui';

import 'package:flutter/material.dart';

import 'loading_anim.dart';

/// A modal overlay that will show over your child widget (fullscreen) when the show value is true
///
/// Wrap your scaffold in this widget and set show value to data.isBusy to show a loading modal when
/// your data state is Busy
class BusyOverlay extends StatelessWidget {
  final Widget child;
  final String title;
  final bool show;

  const BusyOverlay(
      {super.key, required this.child, this.title = 'Please wait...', this.show = false});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Material(
        child: Stack(children: <Widget>[
      child,
      IgnorePointer(
        child: Opacity(
            opacity: show ? 1.0 : 0.0,
            child: ClipRRect(
              child: BackdropFilter(
                filter:  ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                child: Container(
                  width: screenSize.width,
                  height: screenSize.height,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: const LoadingAnim(),
                ),
              ),
            )),
      ),
    ]));
  }
}
