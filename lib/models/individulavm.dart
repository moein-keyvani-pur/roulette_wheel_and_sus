class Individual {
  final dynamic _id;
  final double _fitness;
  const Individual({
    required dynamic id,
    required double fitness,
  })  : _id = id,
        _fitness = fitness;

  /// this field should be uniq for each individul
  /// until recognize which individual selected by [speen] method
  dynamic get id => _id;
  double get fitness => _fitness;
}
