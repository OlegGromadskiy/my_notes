import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension StateExtension on BuildContext{
  S state<S, C extends StateStreamable>() {
    return read<C>().state as S;
  }
}