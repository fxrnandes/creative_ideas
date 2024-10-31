import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'idea_form_screen.dart';
import '../viewmodel/ideas_viewmodel.dart';

class IdeasListScreen extends StatefulWidget {
  @override
  _IdeasListScreenState createState() => _IdeasListScreenState();
}

class _IdeasListScreenState extends State<IdeasListScreen> {
  @override
  void initState() {
    super.initState();
    // Carrega as ideias ao iniciar a tela
    Provider.of<IdeasProvider>(context, listen: false).fetchIdeas();
  }

  @override
  Widget build(BuildContext context) {
    final ideasProvider = Provider.of<IdeasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Creative Ideas'),
        backgroundColor: Color(0xFF5DADEC),
      ),
      body: ideasProvider.ideas.isNotEmpty
          ? ListView.builder(
              itemCount: ideasProvider.ideas.length,
              itemBuilder: (context, index) {
                final idea = ideasProvider.ideas[index];
                return ListTile(
                  title: Text(idea.title),
                  subtitle: Text(idea.description),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      // Confirmação para exclusão
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Excluir Ideia'),
                          content: Text('Tem certeza que deseja excluir esta ideia?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                ideasProvider.deleteIdea(idea.id!);
                                Navigator.pop(context);
                              },
                              child: Text('Excluir', style: TextStyle(color: Colors.redAccent)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Navega para o formulário de edição com a ideia selecionada
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IdeaFormScreen(idea: idea),
                      ),
                    );
                  },
                );
              },
            )
          : Center(child: Text('Sem ideias ainda, crie uma :)')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5DADEC),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Navega para o formulário de criação de nova ideia
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IdeaFormScreen()),
          );
        },
      ),
    );
  }
}
