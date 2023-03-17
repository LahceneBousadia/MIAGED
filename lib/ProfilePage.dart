import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:miaged/LoginPage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  final _formKey = GlobalKey<FormState>();
  late String _birthday;
  late String _address;
  late String _postalCode;
  late String _city;
  late String _newPassword;
  late String _confirmPassword;
  final _passwordFormKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  void _loadCurrentUser() {
    _user = _auth.currentUser;
  }

  Future<void> _signOut() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => login_page()),
    );
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      await _firestore.collection('users').doc(_user?.uid).set({
        'birthday': _birthday,
        'address': _address,
        'postal_code': _postalCode,
        'city': _city
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Les modifications ont été enregistrées avec succès')));
    }
  }

  Future<void> _changePassword() async {
    if (_passwordFormKey.currentState!.validate()) {
      try {
        await _user!.updatePassword(_newPassword);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Le mot de passe a été modifié avec succès')));
        _newPasswordController.clear();
        _confirmPasswordController.clear();
      } catch (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF193D5B),
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _signOut,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Informations personnelles',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: const Color(0xFF193D5B),
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _user?.email,
                      readOnly: true,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      decoration: InputDecoration(
                        labelText: 'Adresse e-mail',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: '',
                      onChanged: (value) => _birthday = value,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      decoration: InputDecoration(
                        labelText: 'Date de naissance',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        hintText: '01/01/2000',
                        hintStyle: TextStyle(
                            color: const Color(0xFF193D5B).withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: '',
                      onChanged: (value) => _address = value,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      decoration: InputDecoration(
                        labelText: 'Adresse',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        hintText: 'Promenade des Anglais',
                        hintStyle: TextStyle(
                            color: const Color(0xFF193D5B).withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: '',
                      onChanged: (value) => _postalCode = value,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Code postal',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        hintText: '06000',
                        hintStyle: TextStyle(
                            color: const Color(0xFF193D5B).withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                    ),
                    TextFormField(
                      initialValue: '',
                      onChanged: (value) => _city = value,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      decoration: InputDecoration(
                        labelText: 'Ville',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        hintText: 'Nice',
                        hintStyle: TextStyle(
                            color: const Color(0xFF193D5B).withOpacity(0.5)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  child: const Text('Enregistrer les modifications'),
                  style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFf6a31c),
                    minimumSize: Size(200, 50),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Text(
                'Changer le mot de passe',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: const Color(0xFF193D5B),
                ),
              ),
              const SizedBox(height: 16.0),
              Form(
                key: _passwordFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _newPasswordController,
                      obscureText: true,
                      onChanged: (value) => _newPassword = value,
                      style: TextStyle(color: const Color(0xFF193D5B)),
                      decoration: InputDecoration(
                        labelText: 'Nouveau mot de passe',
                        labelStyle: TextStyle(color: const Color(0xFF193D5B)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: const Color(0xFF193D5B)),
                        ),
                      ),
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return 'Les mots de passe ne correspondent pas';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _changePassword,
                      child: const Text('Changer le mot de passe'),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFFf6a31c),
                        minimumSize: Size(200, 50),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
