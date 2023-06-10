import 'dart:math';

import 'package:roulette_wheel_and_sus/src/roulette_wheel_and_sus_base.dart';

import '../models/individulavm.dart';

class Sus extends BaseAlgorithm {
  Sus({
    required List<Individual> individualWithFitness,
  }) : super(individualWithFitness: individualWithFitness);

  /// return selected individual's id
  ///
  ///[itemSelect] specifies how many [Individual] you will choose in the rotation
  ///
  /// throw exception when your list is empty
  List<dynamic> spin({required int itemSelect}) {
    try {
      List<dynamic> selectedInd = [];
      if (individualWithFitness.isEmpty) throw Exception('your list is empty');
      initialIndividualHelperList();
      setProbability();
      sortIndividualHelper();
      var distance = 1 / itemSelect;
      double randomNumber = Random().nextDouble() * distance;
      for (var i = 0; i < itemSelect; i++) {
        var item = selectInd(randomNumber: randomNumber);
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
