import 'dart:math';

import 'package:roulette_wheel_and_sus/src/roulette_wheel_and_sus_base.dart';

import '../models/individulavm.dart';

class RouletteWheel extends BaseAlgorithm {
  RouletteWheel({
    required List<Individual> individualWithFitness,
  }) : super(individualWithFitness: individualWithFitness);

  /// return selected individual's id
  ///
  /// throw exception when your list is empty
  dynamic spin() {
    try {
      if (individualWithFitness.isEmpty) throw Exception('your list is empty');
      initialIndividualHelperList();
      setProbability();
      sortIndividualHelper();
      double randomNumber = Random().nextDouble();
      var item = selectInd(randomNumber: randomNumber);
      return individualWithFitness
          .firstWhere((element) => element.id == item.id)
          .id;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
