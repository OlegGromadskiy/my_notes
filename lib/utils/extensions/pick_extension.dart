import 'package:flutter_bloc/flutter_bloc.dart';

extension When<T> on StateStreamable<T>{
  Stream<S> when<S>(){
    return stream.where((state) => state is S).cast<S>();
  }
}

