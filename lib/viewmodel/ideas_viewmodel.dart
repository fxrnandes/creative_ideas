import 'package:flutter/material.dart';
import '../models/idea.dart';
import '../services/idea_service.dart';

class IdeasProvider extends ChangeNotifier {
  final IdeaService _ideaService = IdeaService();
  List<Idea> _ideas = [];

  List<Idea> get ideas => _ideas;

  Future<void> fetchIdeas() async {
    _ideas = await _ideaService.getIdeas();
    notifyListeners();
  }

  Future<void> addIdea(Idea idea) async {
    await _ideaService.addIdea(idea);
    fetchIdeas();  // Atualiza a lista após adicionar
  }

  Future<void> updateIdea(Idea idea) async {
    await _ideaService.updateIdea(idea);
    fetchIdeas();
  }

  Future<void> deleteIdea(String id) async {
    await _ideaService.deleteIdea(id);
    fetchIdeas();
  }
}
