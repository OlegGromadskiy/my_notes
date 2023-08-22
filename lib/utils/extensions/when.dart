extension When<T> on T {
  void when<S extends T>(void Function(S state) handler) {
    if (this is S) {
      return handler(this as S);
    }
  }
}
