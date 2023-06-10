import 'package:roulette_wheel_and_sus/models/individulavm.dart';
import 'package:roulette_wheel_and_sus/roulette_wheel_and_sus.dart';
import 'dart:math' as math;

void main() {
  /// our dataset is like bottom:
  ///
  /// it has a very important property but we show 3 of them: "id" , "name","age"
  var dataset = [
    {'id': 1, "name": "john", "age": 10},
    {'id': 2, "name": "Naomi", "age": 43},
    {'id': 3, "name": "Jeffrey", "age": 23},
    {'id': 4, "name": "Bill ", "age": 12},
    {'id': 5, "Gloria": "john", "age": 45},
  ];
  for (var element in dataset) {
    _getFitness(element);
  }
  List<Individual> individuals = dataset
      .map((e) =>
          Individual(id: e['id'], fitness: (e['fitness'] as int).toDouble()))
      .toList();
  var roulettWheel = RouletteWheel(individualWithFitness: individuals);
  var selectedItem = roulettWheel.spin();
  print(selectedItem);
  var sus = Sus(individualWithFitness: individuals);
  var selectedItemsBySus = sus.spin(itemSelect: 10);
  print(selectedItemsBySus);
}

void _getFitness(Map<String, dynamic> item) {
  item.putIfAbsent('fitness', () => math.Random().nextInt(40));
}
