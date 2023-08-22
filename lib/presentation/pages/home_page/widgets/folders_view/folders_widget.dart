import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/folders_view/widgets/folders_data_view.dart';
import 'package:my_notes/presentation/pages/home_page/widgets/folders_view/widgets/folders_loading_view.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_cubit.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_state.dart';

class FoldersWidget extends StatelessWidget {
  const FoldersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 1.0),
        color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: BlocBuilder<FoldersCubit, FoldersState>(
          builder: (context, state) => switch (state) {
            FoldersDataState(folders: var f, selectedFolder: var s) =>
              FoldersDataView(folders: f, selectedFolder: s),
            FoldersLoadingState() => const FoldersLoadingView(),
          },
        ),
      ),
    );
  }
}
