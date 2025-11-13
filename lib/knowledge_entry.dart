class KnowledgeEntry {
  final List<String> keywords; 
  final String response;      

  KnowledgeEntry({required this.keywords, required this.response});

  factory KnowledgeEntry.fromJson(Map<String, dynamic> json) {
    return KnowledgeEntry(
      keywords: List<String>.from(json['keywords'] as List), 
      response: json['response'] as String,
    );
  }
}