import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:core';

import '../models/user.dart';
import '../provider/users.dart';

class UserForm extends StatelessWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;
    print(user.name);
    final _form = GlobalKey<FormState>();
    final Map<String, String> _formData = {};

    if (user != null) {
      final loadUser = user as User;
      _formData["id"] = user.id;
      _formData["name"] = user.name;
      _formData["email"] = user.email;
      _formData["avatarUrl"] = user.avatarUrl;
    }

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
                initialValue: _formData["name"]?.toString(),
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
                initialValue: _formData["email"]?.toString(),
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (value) => _formData["email"] = value ?? "",
              ),
              TextFormField(
                initialValue: _formData["avatarUrl"]?.toString(),
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
