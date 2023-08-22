import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/folder.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/explorer_item.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_cubit.dart';

class FoldersDataView extends StatelessWidget {
  final List<Folder> folders;
  final Folder? selectedFolder;

  const FoldersDataView({
    Key? key,
    required this.folders,
    required this.selectedFolder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];

              return ExplorerItem(
                title: folder.title,
                isSelected: folder == selectedFolder,
                onTap: () => context.read<FoldersCubit>().selectFolder(folder),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: FractionallySizedBox(
            widthFactor: 1.0,
            child: OutlinedButton(
              onPressed: () => context.read<FoldersCubit>().createFolder('new folder'),
              child: const Text('+'),
            ),
          ),
        ),
      ],
    );
  }
}
