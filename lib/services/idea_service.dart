import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/idea.dart';

class IdeaService {
  final CollectionReference ideasCollection =
      FirebaseFirestore.instance.collection('ideas');

  Future<List<Idea>> getIdeas() async {
    final querySnapshot = await ideasCollection.get();
    return querySnapshot.docs
        .map((doc) => Idea.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> addIdea(Idea idea) async {
    final docRef = await ideasCollection.add(idea.toMap());
    idea.id = docRef.id; // Define o ID após a criação
  }

  Future<void> updateIdea(Idea idea) async {
    await ideasCollection.doc(idea.id).update(idea.toMap());
  }

  Future<void> deleteIdea(String id) async {
    await ideasCollection.doc(id).delete();
  }
}
