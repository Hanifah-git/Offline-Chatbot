import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'knowledge_entry.dart'; 

class KnowledgeService {
  static const String _knowledgePath = 'assets/knowledge_base.json';

  Future<List<KnowledgeEntry>> loadKnowledgeBase() async {
    try {
      final String jsonString = await rootBundle.loadString(_knowledgePath);

      final List<dynamic> jsonList = jsonDecode(jsonString);

      return jsonList
          .map((json) => KnowledgeEntry.fromJson(json))
          .toList();

    } catch (e) {
      print("Error loading knowledge base: $e");
      return []; 
    }
  }
}