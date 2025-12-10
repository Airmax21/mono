class Parser {
  Parser();

  static double cleanNumber(String formattedText) {
    String cleanText = formattedText.replaceAll('.', '');

    double? parsedValue = double.tryParse(cleanText);
    if (parsedValue != null) {
      return parsedValue;
    } else {
      return 0.0;
    }
  }
}
