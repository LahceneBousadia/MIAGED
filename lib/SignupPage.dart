import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:miaged/HomePage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String _email, _password, _dateNaissance, _adresse, _codePostal, _ville;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset('assets/miaged.png', width: 200, height: 200),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse e-mail';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Adresse e-mail',
                ),
                onSaved: (value) {
                  _email = value!;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer un mot de passe';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                ),
                obscureText: true,
                onSaved: (value) {
                  _password = value!;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre date de naissance';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Date de naissance (jj/mm/aaaa)',
                ),
                onSaved: (value) {
                  _dateNaissance = value!;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre adresse';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Adresse',
                ),
                onSaved: (value) {
                  _adresse = value!;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre code postal';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Code postal',
                ),
                onSaved: (value) {
                  _codePostal = value!;
                },
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez entrer votre ville';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Ville',
                ),
                onSaved: (value) {
                  _ville = value!;
                },
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                child: Text('Sinscrire'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: _email, password: _password);
                      if (newUser != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
