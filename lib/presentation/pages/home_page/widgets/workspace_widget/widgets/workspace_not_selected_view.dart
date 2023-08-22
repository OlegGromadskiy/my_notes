import 'package:flutter/material.dart';

class WorkspaceNotSelectedView extends StatelessWidget {
  const WorkspaceNotSelectedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.question_mark_rounded),
          const SizedBox(height: 16.0),
          Text('Workspace not selected yet'),
        ],
      ),
    );
  }
}
