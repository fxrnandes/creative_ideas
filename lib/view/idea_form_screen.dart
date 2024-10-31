import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/idea.dart';
import '../viewmodel/ideas_viewmodel.dart';

class IdeaFormScreen extends StatefulWidget {
  final Idea? idea;

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
      _titleController.text = widget.idea!.title;
      _descriptionController.text = widget.idea!.description;
    }
  }

  void _saveIdea() {
    if (_formKey.currentState!.validate()) {
      final newIdea = Idea(
        title: _titleController.text,
        description: _descriptionController.text,
      );

      final ideasProvider = Provider.of<IdeasProvider>(context, listen: false);

      if (widget.idea != null) {
        newIdea.id = widget.idea!.id;  // Define o ID apenas se for uma atualização
        ideasProvider.updateIdea(newIdea);
      } else {
        ideasProvider.addIdea(newIdea);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idea == null ? 'Adicionar ideia' : 'Editar ideia'),
        backgroundColor: Color(0xFF5DADEC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) => value!.isEmpty ? 'Insira um título válido' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Insira uma descrição válida' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveIdea,
                child: Text(widget.idea == null ? 'Adicionar ideia' : 'Atualizar ideia'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
