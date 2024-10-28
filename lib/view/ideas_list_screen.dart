import 'package:flutter/material.dart';
import '../view/idea_form_screen.dart';

class IdeasListScreen extends StatefulWidget {
  @override
  _IdeasListScreenState createState() => _IdeasListScreenState();
}

class _IdeasListScreenState extends State<IdeasListScreen> {
  List<Map<String, String>> ideasList = [];

  void _addOrEditIdea({Map<String, String>? idea, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IdeaFormScreen(idea: idea),
      ),
    );

    if (result != null) {
      setState(() {
        if (index != null) {
          ideasList[index] = result;
        } else {
          ideasList.add(result);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 232, 255), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Color(0xFF5DADEC), // Cor primária
        title: Text(
          'Creative Ideas',
          style: TextStyle(
            color: Color(0xFFFFFFFF), // Texto em branco para contraste
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ideasList.isNotEmpty
          ? ListView.builder(
              itemCount: ideasList.length,
              itemBuilder: (context, index) {
                final idea = ideasList[index];
                return Card(
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    title: Text(
                      idea['title'] ?? 'No title',
                      style: TextStyle(
                        color: Color(0xFF333333), // Texto principal
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      idea['description'] ?? 'No description',
                      style: TextStyle(
                        color: Color(0xFF666666), // Texto secundário
                      ),
                    ),
                    onTap: () => _addOrEditIdea(idea: idea, index: index),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Color.fromARGB(255, 238, 97, 97)), // Cor secundária
                      onPressed: () {
                        setState(() {
                          ideasList.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Sem ideias ainda, adicione a sua primeira :)',
                style: TextStyle(
                  color: Color(0xFF666666),
                  fontSize: 16,
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF5DADEC), // Cor primária
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _addOrEditIdea(),
      ),
    );
  }
}
