class Helper {
  static String errorMessage(String error) {
    return error.startsWith("Exception:")
        ? error.replaceFirst("Exception: ", "")
        : error;
  }
}
