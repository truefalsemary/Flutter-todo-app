enum Importance {
  low,
  basic,
  important;

  parseToString() {
    switch (this) {
      case Importance.low:
        return 'no';
      case Importance.basic:
        return 'low';
      case Importance.important:
        return 'high';
    }
  }

  static Importance fromString(String importance) {
    if (importance == 'no') {
      return Importance.low;
    } else if (importance == 'low') {
      return Importance.basic;
    } else {
      return Importance.important;
    }
  }
}
