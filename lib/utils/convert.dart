class Convert {
  static String formatNumber(int number) {
    if (number >= 1000) {
      double num = number / 1000;
      if (num % 1 == 0) {
        return '${num.toInt()}k';
      } else {
        return '${num.toStringAsFixed(1)}k';
      }
    } else {
      return number.toString();
    }
  }
}
