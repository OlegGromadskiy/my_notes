extension ForEachType on Stream {
  void forEachType<T>(void Function(T state) handler) {
    where((event) => event is T).cast<T>().forEach(handler);
  }
}
