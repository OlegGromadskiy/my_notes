import 'package:flutter/material.dart';

class FoldersLoadingView extends StatelessWidget {
  const FoldersLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
