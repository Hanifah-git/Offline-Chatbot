import 'knowledge_entry.dart';

final Set<String> _stopWords = {
  'a', 'an', 'the', 'is', 'are', 'was', 'were', 'and', 'or', 'but', 'for', 
  'not', 'in', 'on', 'at', 'with', 'from', 'about', 'can', 'i', 'my', 'me', 'where', 'what' 
};

final Map<String, String> _aliasMap = {
  'doc': 'clinic', 
  'medical': 'clinic', 
  'edu': 'school', 
  'learn': 'school', 
  'feeding': 'food',
};

class NLPEngine {
  KnowledgeEntry? findBestMatch(String query, List<KnowledgeEntry> knowledgeBase) {
    
    final cleanQueryWords = query
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s]'), '') 
        .split(' ')
        .where((word) => word.isNotEmpty && !_stopWords.contains(word))
        .map((word) => _aliasMap[word] ?? word)
        .toSet(); 
    
    int bestScore = 0;
    KnowledgeEntry? bestMatch;

    for (final entry in knowledgeBase) {
      int currentScore = 0;
      
      for (final keyword in entry.keywords) {
        if (cleanQueryWords.contains(keyword)) {
          currentScore++;
        }
      }

      if (currentScore > bestScore) {
        bestScore = currentScore;
        bestMatch = entry;
      }
    }

    return bestMatch;
  }
}