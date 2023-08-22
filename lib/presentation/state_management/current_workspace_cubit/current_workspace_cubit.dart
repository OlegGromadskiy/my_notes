import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_notes/domain/models/workspace.dart';
import 'package:my_notes/domain/models/workspace_card.dart';
import 'package:my_notes/presentation/state_management/current_workspace_cubit/current_workspace_state.dart';
import 'package:my_notes/utils/extensions/when.dart';

class CurrentWorkspaceCubit extends Cubit<CurrentWorkspaceState> {
  CurrentWorkspaceCubit() : super(CurrentWorkspaceNotSelectedState());

  Future<void> updateWorkspace(Workspace workspace) async {
    emit(CurrentWorkspaceSelectedState(workspace));
  }

  Future<void> createCard(Offset position) async {
    state.when<CurrentWorkspaceSelectedState>((state) {
      state.selectedWorkspace.cards.add(
        WorkspaceCard(
          rect: Rect.fromLTWH(position.dx, position.dy, 100.0, 100.0),
          cardComponents: [],
        ),
      );

      emit(CurrentWorkspaceSelectedState(state.selectedWorkspace));
    });
  }
}
