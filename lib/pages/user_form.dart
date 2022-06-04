import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../provider/users.dart';

class UserForm extends StatelessWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _form = GlobalKey<FormState>();
    final Map<String, String> _formData = {};
    // final users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Usuário"),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState?.validate() ?? false;

                if (isValid == true) {
                  _form.currentState?.save();

                  Provider.of<Users>(context, listen: false)
                      .saveUser(_formData);
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nome"),
                onSaved: (value) => _formData["name"] = value ?? "",
                validator: (_value) {
                  final value = _value ?? "";
                  if (value == null || value.trim().isEmpty) {
                    return "Campo obrigatório";
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (value) => _formData["email"] = value ?? "",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "URL do avatar"),
                onSaved: (value) => _formData["avatarUrl"] = value ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
