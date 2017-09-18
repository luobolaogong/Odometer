// I don't know why this version is a lot slower than the recursive version.

import 'dart:math';

// I think the idea here is to have an array of wheels or digits that get set up when first
// created, say having 3 digits, and each wheel has the same base.  So a binary
// Odometer of 3 digits would start out as 000 (reject), then when incremented would go
// 001 (reject), 010 (double reject), 011 (reject), 100 (reject), 101, 110 (reject), 111,
// and then stop or possibly go back to 000.
//
// It's important to set the size, because that's the requirement for the problem.
// We cant start with a "decimal" number and start incrementing, and converting
// to the base at every increment, and then check if the number has exceeded the
// digits limit of 3.  Well, you could, I guess.  But you have to convert and then
// check for a starting or ending 0 (and throw it out because it won't be a 3 digit
// number

class Odometer {
  final int nDigits;
  final int base;
  int value;
  List<int> digits; // digits[0] is the highest order digit

  Odometer(this.base, this.nDigits, {this.value: 0}) {
    this.digits = new List<int>.filled(this.nDigits, 0);
    if (this.value != 0) {
      this.digits = convertValueToDigits(this.value); // check this.
    }
  }

  int getNDigits() {
    return nDigits;
  }

  int getBase() {
    return base;
  }

  //int get nDigits => nDigits;

  int getValue() {
    return this.value;
  }

  // Are these useful?  Used them in previous recursive version.
  List<int> getForwardNumberList() {
    return digits;
  }
  List<int> getReversedNumberList() {
    return new List<int>.from(digits.reversed);
  }



  int getReversedValue() {
    String reverseString = toReversedString();
    int reverseValue = int.parse(reverseString, radix:this.base);
    return reverseValue;
  }

  String toString() {
    //Probably a better way to do this
    String resultString = '';
    for (int ctr = 0; ctr < this.nDigits; ctr++) {
      int digit = this.digits.elementAt(ctr);
      String digitInBaseCharacter = digit.toRadixString(this.base);
      resultString = resultString + digitInBaseCharacter;
    }
    return resultString;
  }

  String toReversedString() {
    //Probably a better way to do this
    String resultString = '';
    for (int ctr = 0; ctr < this.nDigits; ctr++) {
      int digit = this.digits.elementAt(ctr);
      String digitInBaseCharacter = digit.toRadixString(this.base);
      resultString = digitInBaseCharacter + resultString;
    }
    return resultString;
  }


  bool isOverflow(int value, int base, int nDigits) {
    int maxValue = pow(base, nDigits);
    if (value >= maxValue) {
      return true;
    }
    return false;
  }

  increment() {
    this.value++;
    if (isOverflow(this.value, this.base, this.nDigits)) {
      this.digits.fillRange(0, this.nDigits, 0);
      this.value = 0;
      return;
    }
    this.digits = convertValueToDigits(this.value);
  }

  List<int> convertValueToDigits(int value) {
    List<int> digits = new List<int>.filled(this.nDigits, 0);
    String digitsString = value.toRadixString(this.base);
    int digitsIndex = this.nDigits - 1;
    for (int digitsStringIndex = digitsString.length; digitsStringIndex > 0; digitsStringIndex--) {
      String whatever = digitsString.substring(digitsStringIndex - 1, digitsStringIndex);
      int whateverAsInt = int.parse(whatever, radix:this.base);
      digits[digitsIndex] = whateverAsInt;
      digitsIndex--;
    }
    return digits;
  }


}

