import 'package:flutter/material.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/folders_view/folders_widget.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspace_widget/workspace_widget.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/workspaces_view/workspaces_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Row(
        children: [
          FoldersWidget(),
          WorkspacesWidget(),
          WorkspaceWidget(),
        ],
      ),
    );
  }
}
