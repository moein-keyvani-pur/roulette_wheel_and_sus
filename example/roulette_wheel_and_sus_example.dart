import 'package:roulette_wheel_and_sus/models/individulavm.dart';
import 'package:roulette_wheel_and_sus/roulette_wheel_and_sus.dart';
import 'dart:math' as math;

void main() {
  List<Individual> _items = List.generate(
      50,
      (index) => Individual(
          id: math.Random().nextBool(),
          fitness: math.Random().nextInt(20).toDouble()));
  var roulettWheel = RouletteWheel(individualWithFitness: _items);
  var item = roulettWheel.spin();
  print(item);
  var sus = Sus(individualWithFitness: _items);
  var items = sus.spin(itemSelect: 10);
  print(items);
}
