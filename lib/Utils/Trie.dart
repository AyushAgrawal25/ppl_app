class Trie {
  String value;
  late Set<int> taskIds;
  late Map<String, Trie> links;

  Trie({required this.value}) {
    taskIds = new Set();
    links = {};
  }

  void insert(String title, int taskId) {
    if (title.length == 0) {
      return;
    }

    String firstChar = title.substring(0, 1);
    if (links[firstChar] == null) {
      links[firstChar] = new Trie(value: firstChar);
    }

    taskIds.add(taskId);
    links[firstChar]!.insert(title.substring(1), taskId);
  }

  void delete(String title, int taskId) {
    if (title.length == 0) {
      return;
    }

    taskIds.remove(taskId);
    String firstChar = title.substring(0, 1);
    if (links[firstChar] == null) {
      return;
    }
    links[firstChar]!.delete(title.substring(1), taskId);
  }

  Set<int> search(String title) {
    if (title.length == 0) {
      return taskIds;
    }

    String firstChar = title.substring(0, 1);
    if (links[firstChar] == null) {
      return Set<int>();
    }

    return links[firstChar]!.search(title.substring(1));
  }
}
