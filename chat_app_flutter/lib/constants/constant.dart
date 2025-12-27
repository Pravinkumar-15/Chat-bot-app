class Constants {
  static int? unreadCountForIndex(int index) {
    if (index == 0) {
      return 2;
    }
    if (index == 2) {
      return 1;
    }
    return null;
  }

  static String initialForName(String name) {
    final trimmed = name.trim();
    return trimmed.isNotEmpty ? trimmed.substring(0, 1).toUpperCase() : '?';
  }

  static String timeLabelForIndex(int index) {
    const labels = <String>[
      '2 min ago',
      '10 min ago',
      '1 hour ago',
      '3 hours ago',
      '5 hours ago',
      'Yesterday',
      'Yesterday',
      '2 days ago',
    ];
    if (index < labels.length) {
      return labels[index];
    }
    return '2 days ago';
  }
}

enum PageState { home, offers, settings }

enum MessageSide { left, right }
