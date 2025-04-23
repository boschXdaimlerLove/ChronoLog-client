final class TimeFrame {
  TimeFrame(this.start, this.end) {
    if (start.year != end.year ||
        start.month != end.month ||
        start.day != end.day) {
      // TODO: throw error
    }
  }

  DateTime start;
  DateTime end;

  Duration getWorkingTime() {
    return start.difference(end);
  }
}