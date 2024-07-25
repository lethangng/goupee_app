class Level {
  static String lv(int level) {
    late String leverValue;
    switch (level) {
      case 1:
        leverValue = 'assets/icons/lv1.png';
        break;
      case 2:
        leverValue = 'assets/icons/lv2.png';
        break;
      case 3:
        leverValue = 'assets/icons/lv3.png';
        break;
      case 4:
        leverValue = 'assets/icons/lv4.png';
        break;
      case 5:
        leverValue = 'assets/icons/lv5.png';
        break;
      case 6:
        leverValue = 'assets/icons/lv6.png';
        break;
      case 7:
        leverValue = 'assets/icons/lv7.png';
        break;
      case 8:
        leverValue = 'assets/icons/lv8.png';
        break;
      default:
        leverValue = 'assets/icons/lv1.png';
    }
    return leverValue;
  }
}
