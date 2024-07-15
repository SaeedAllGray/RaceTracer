class TopicInfo {
  final String type;
  final List<String> subscribers;
  final List<String> publishers;

  TopicInfo({
    required this.type,
    required this.subscribers,
    required this.publishers,
  });
}
