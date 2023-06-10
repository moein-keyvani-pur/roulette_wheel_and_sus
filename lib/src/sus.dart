import 'dart:math';

import '../models/individulavm.dart';

class Sus {
  List<Individual> _individualWithFitness;
  Sus({
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

  void _initialIndividualHelperList() {
    _setIndividualHelperList = [];
    for (var element in individualWithFitness) {
      _getIndividualHelperList
          .add(_IndividualHelper(id: element.id, fitness: element.fitness));
    }
  }

  void _setProbability() {
    double sumFitnesses = _getSumFitnesses();
    for (var i = 0; i < _getIndividualHelperList.length; i++) {
      var probability = _getIndividualHelperList[i].fitness / sumFitnesses;
      _getIndividualHelperList[i].setProbability =
          double.parse(probability.toStringAsFixed(_decimalPlaces));
    }
  }

  void _sortIndividualHelper() {
    _getIndividualHelperList.sort(
      (a, b) => (a.probability ?? 0.0).compareTo(b.probability ?? 0.0),
    );
  }

  _IndividualHelper _selectInd({required double randomNumber}) {
    late _IndividualHelper ind;
    for (var i = 0; i < _getIndividualHelperList.length; i++) {
      if (_sumFirstUntilIndex(index: i) <= randomNumber &&
          randomNumber < _sumFirstUntilIndex(index: i + 1)) {
        ind = _getIndividualHelperList[i];
        return ind;
      }
    }
    return ind;
  }

  double _sumFirstUntilIndex({required int index}) {
    double sum = 0;
    for (var i = 0; i < index; i++) {
      sum += (_getIndividualHelperList[i].probability!);
    }
    return sum;
  }

  double _getSumFitnesses() {
    List<double> fitnesses =
        individualWithFitness.map((e) => e.fitness).toList();
    var sum = 0.0;
    for (var element in fitnesses) {
      sum += element;
    }
    return sum;
  }

  /// return selected individual's id
  ///
  ///[itemSelect] specifies how many [Individual] you will choose in the rotation
  ///
  /// throw exception when your list is empty
  List<dynamic> spin({required int itemSelect}) {
    try {
      List<dynamic> selectedInd = [];
      if (individualWithFitness.isEmpty) throw Exception('your list is empty');
      _initialIndividualHelperList();
      _setProbability();
      _sortIndividualHelper();
      var distance = 1 / itemSelect;
      double randomNumber = Random().nextDouble() * distance;
      for (var i = 0; i < itemSelect; i++) {
        _IndividualHelper item = _selectInd(randomNumber: randomNumber);
        selectedInd.add(individualWithFitness
            .firstWhere((element) => element.id == item.id)
            .id);
        randomNumber += distance;
      }
      return selectedInd;
    } catch (e) {
      throw Exception(e.toString());
    }
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
