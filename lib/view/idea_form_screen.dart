import 'package:flutter/material.dart';

class IdeaFormScreen extends StatefulWidget {
  final Map<String, String>? idea;

  IdeaFormScreen({this.idea});

  @override
  _IdeaFormScreenState createState() => _IdeaFormScreenState();
}

class _IdeaFormScreenState extends State<IdeaFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.idea != null) {
      _titleController.text = widget.idea!['title'] ?? '';
      _descriptionController.text = widget.idea!['description'] ?? '';
    }
  }

  void _saveIdea() {
    if (_formKey.currentState!.validate()) {
      final idea = {
        'title': _titleController.text,
        'description': _descriptionController.text,
      };
      Navigator.pop(context, idea);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 202, 232, 255), // Cor de fundo
      appBar: AppBar(
        backgroundColor: Color(0xFF5DADEC), // Cor primária
        title: Text(
          widget.idea == null ? 'Adicionar ideia' : 'Editar ideia',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Título da ideia',
                  labelStyle: TextStyle(color: Color(0xFF333333)),
                ),
                validator: (value) => value!.isEmpty ? 'Enter a title' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descrição da ideia',
                  labelStyle: TextStyle(color: Color(0xFF333333)),
                ),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Enter a description' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveIdea,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF5DADEC), // Cor primária
                ),
                child: Text(
                  widget.idea == null ? 'Adicionar ideia' : 'Atualizar ideia',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
