import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:my_notes/data/data_sources/folders_data_sources/folders_data_source.dart';
import 'package:my_notes/data/data_sources/folders_data_sources/hive_folders_data_source.dart';
import 'package:my_notes/data/repos_impls/folders_repo_impl.dart';
import 'package:my_notes/domain/repos/folders_repo.dart';
import 'package:my_notes/presentation/state_management/current_workspace_cubit/current_workspace_cubit.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_cubit.dart';
import 'package:my_notes/presentation/state_management/folders_cubit/folders_state.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_cubit.dart';
import 'package:my_notes/presentation/state_management/workspace_cubit/workspace_state.dart';
import 'package:my_notes/utils/extensions/for_each_type.dart';

class DiContainer extends StatelessWidget {
  final Widget child;

  const DiContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FoldersDataSource>(
          create: (context) => HiveFoldersDataSource(Hive.box('folders')),
        ),
        RepositoryProvider<FoldersRepo>(create: (context) => FoldersRepoImpl(context.read())),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CurrentWorkspaceCubit()),
          BlocProvider(
            create: (context) {
              final cubit = WorkspacesCubit();

              cubit.stream.forEachType<WorkspacesDataState>((state) {
                if (state.selectedWorkspace != null) {

                  context.read<CurrentWorkspaceCubit>().updateWorkspace(state.selectedWorkspace!);
                }
              });

              return cubit;
            },
          ),
          BlocProvider<FoldersCubit>(
            create: (context) {
              final cubit = FoldersCubit(context.read());

              cubit.stream.forEachType<FoldersDataState>((state) {
                if (state.selectedFolder != null) {
                  context.read<WorkspacesCubit>().updateFolder(state.selectedFolder!);
                }
              });

              cubit.loadFolders();
              return cubit;
            },
          ),
        ],
        child: child,
      ),
    );
  }
}
