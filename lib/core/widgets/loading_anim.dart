import 'package:flutter/material.dart';

class LoadingAnim extends StatelessWidget {
  const LoadingAnim({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
