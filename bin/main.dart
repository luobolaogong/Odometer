// Copyright (c) 2017, rob. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.
import 'dart:math';

import 'package:Odometer/Odometer.dart' as Odometer;

main(List<String> arguments) {
  int minDigitsForComparison = 4;
  int maxDigitsForComparison = 8;
  int minBase = 10;
  int maxBase = 10;
  print("Starting at " + (new DateTime.now()).toString());
  Stopwatch stopWatch = new Stopwatch();
  for (int base = minBase; base <= maxBase; base++) {
    for (int nDigits = minDigitsForComparison; nDigits <= maxDigitsForComparison; nDigits++) {
      stopWatch.start();


      Odometer.Odometer odometer = new Odometer.Odometer(base, nDigits);
      int maxValue = ((pow(base, nDigits)) / 2.0).ceil();
      //for (int ctr = 0; ctr < maxValue; ctr++, odometer.increment()) {
      for (int ctr = 0; ctr < maxValue; ctr++, odometer.increment()) {
        //print("Base ${odometer.getBase()}: ${odometer.toString()}:${odometer.toReverseString()} decimal: ${odometer.getValue()}:${odometer.getReverseValue()}");
        if (odometer.digits[0] == 0 || odometer.digits[nDigits - 1] == 0) {
          //print("Skipping values not the right length.");
          continue;
        }
        if (odometer.getValue() == odometer.getReversedValue()) {
          //print("Skipping values that are the same back and forward.");
          continue;
        }
        int mDivNRemainder = odometer.getReversedValue() % odometer.getValue();
        if (mDivNRemainder == 0) {
          int wholeNumberMultiple = odometer.getReversedValue() ~/
              odometer.getValue();
          print(
              "Base $base, digits:${odometer.getNDigits()}, n: ${odometer
                  .getValue()
                  .toRadixString(base)}, m: ${odometer.getReversedValue()
                  .toRadixString(base)},  ${wholeNumberMultiple.toRadixString(
                  base)} * ${odometer.getValue().toRadixString(
                  base)} == ${odometer
                  .getReversedValue().toRadixString(base)}");
          continue;
        }
      }
      stopWatch.stop();
      print("\tProcessed ${odometer.getNDigits()}-digit numbers in base $base in ${stopWatch
          .elapsed.inSeconds} second(s).");
      stopWatch.reset();
    }
    //odometer.increment();
  }
}
