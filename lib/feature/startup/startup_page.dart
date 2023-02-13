import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:to_do/core/shared/app_styles.dart';

import 'startup_controller.dart';

class StartUpPage extends StatefulWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  StartUpViewState createState() => StartUpViewState();
}

class StartUpViewState extends State<StartUpPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    _controller.forward();
    _controller.addListener(() {
      if(_controller.isCompleted){
        //run startup logic once animation completed
        Get.find<StartUpController>().handleStartUpLogic();
      }
    });


    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartUpController>(
        builder: (controller) => Scaffold(
              backgroundColor: Colors.white,
              body: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: _controller,
                        curve: const Interval(.3, 1.0, curve: Curves.easeOut))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.note_alt_outlined,
                      size: 32,
                    ).paddingSymmetric(horizontal: 16),
                    Text(
                      'ToDo',
                      style:
                      AppStyles.kHeading2Style.copyWith(fontWeight: FontWeight.w900),
                    ).center(),
                  ],
                ).center(),
              ),
            ));
  }
}
