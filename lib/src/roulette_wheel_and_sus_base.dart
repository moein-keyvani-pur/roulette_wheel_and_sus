import 'models/individula_vm.dart';

class BaseAlgorithm {
  List<Individual> _individualWithFitness;
  BaseAlgorithm({
    required List<Individual> individualWithFitness,
  }) : _individualWithFitness = individualWithFitness;
  final int _decimalPlaces = 4;
  late List<_IndividualHelper> _individualHelperList;
  List<_IndividualHelper> get _getIndividualHelperList => _individualHelperList;
  set _setIndividualHelperList(List<_IndividualHelper> items) {
    _individualHelperList = items;
  }

  List<Individual> get individualWithFitness => _individualWithFitness;
  set setIndividualWithFitness(List<Individual> arg) {
    _individualWithFitness.clear();
    _individualWithFitness = List.of(arg);
  }

  void initialIndividualHelperList() {
    _setIndividualHelperList = [];
    for (var element in individualWithFitness) {
      _getIndividualHelperList
          .add(_IndividualHelper(id: element.id, fitness: element.fitness));
    }
  }

  void setProbability() {
    double sumFitnesses = getSumFitnesses();
    for (var i = 0; i < _getIndividualHelperList.length; i++) {
      var probability = _getIndividualHelperList[i].fitness / sumFitnesses;
      _getIndividualHelperList[i].setProbability =
          double.parse(probability.toStringAsFixed(_decimalPlaces));
    }
  }

  void sortIndividualHelper() {
    _getIndividualHelperList.sort(
      (a, b) => (a.probability ?? 0.0).compareTo(b.probability ?? 0.0),
    );
  }

  _IndividualHelper selectInd({required double randomNumber}) {
    late _IndividualHelper ind;
    for (var i = 0; i < _getIndividualHelperList.length; i++) {
      if (sumFirstUntilIndex(index: i) <= randomNumber &&
          randomNumber < sumFirstUntilIndex(index: i + 1)) {
        ind = _getIndividualHelperList[i];
        return ind;
      }
    }
    return ind;
  }

  double sumFirstUntilIndex({required int index}) {
    double sum = 0;
    for (var i = 0; i < index; i++) {
      sum += (_getIndividualHelperList[i].probability!);
    }
    return sum;
  }

  double getSumFitnesses() {
    List<double> fitnesses =
        individualWithFitness.map((e) => e.fitness).toList();
    var sum = 0.0;
    for (var element in fitnesses) {
      sum += element;
    }
    return sum;
  }
}

class _IndividualHelper {
  final dynamic _id;
  final double _fitness;
  double? _probability;
  _IndividualHelper({
    required dynamic id,
    required double fitness,
  })  : _id = id,
        _fitness = fitness;
  dynamic get id => _id;
  double get fitness => _fitness;
  set setProbability(double probabilityArg) {
    _probability = probabilityArg;
  }

  double? get probability => _probability;
}
