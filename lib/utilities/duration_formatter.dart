class DurationFormatter {
  /// Converts a [Duration] object into a human-friendly string.
  ///
  /// Examples:
  /// - 1 minute -> "1 m"
  /// - 1 hour and 30 minutes -> "1 h, 30 m"
  /// - Less than a minute -> "< 1 m"
  static String formatDuration(Duration? duration) {
    if (duration == null || duration.inSeconds == 0) {
      return "< 1 m";
    }

    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;

    if (hours > 0 && minutes > 0) {
      return "$hours h, $minutes m";
    } else if (hours > 0) {
      return "$hours h";
    } else if (minutes > 0) {
      return "$minutes m";
    } else {
      return "< 1 m";
    }
  }
}
