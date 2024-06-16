import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  static const sampleNumber = '0000000000';

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > oldValue.text.length) {
      // If newly entered text length exceeds sample number's length
      // then return the old value.
      if (newValue.text.length > sampleNumber.length) {
        return oldValue;
      }

      // Check if the recently entered character is a digit or not.
      final lastEnteredLetter =
          newValue.text.substring(newValue.text.length - 1);
      if (!RegExp(r'[0-9]').hasMatch(lastEnteredLetter)) {
        return oldValue;
      }

      // If the index of the last entered character in the `newValue`
      // is n, and in the n-th index of the sampleNumber there is a
      // separator, then modify the text.
      if (newValue.text.isNotEmpty &&
          sampleNumber[newValue.text.length - 1] == '') {
        return TextEditingValue(
          text:
              '${oldValue.text}${newValue.text.substring(newValue.text.length - 1)}',
          selection:
              TextSelection.collapsed(offset: newValue.selection.end + 1),
        );
      }
    }
    return newValue;
  }
}
