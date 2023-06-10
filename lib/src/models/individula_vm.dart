class Individual {
  final dynamic _id;
  final double _fitness;
  const Individual({
    required dynamic id,
    required double fitness,
  })  : _id = id,
        _fitness = fitness;

  ///This field must be unique for each individual
  ///to identify which individual was selected by the [spin] function
  dynamic get id => _id;
  double get fitness => _fitness;
}
