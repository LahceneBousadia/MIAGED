import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'SignupPage.dart';

class login_page extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<login_page> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _error = '';
  bool _obscureText = true;

  Future<void> signIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        setState(() {
          _error = 'Aucun utilisateur trouvé pour cet email';
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          _error = 'Mot de passe incorrect';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF193D5B),
        title: Text(
          'Connexion',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/miaged.png',
              height: 230,
              width: 230,
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                ),
              ),
              obscureText: _obscureText,
            ),
            SizedBox(height: 12.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  signIn();
                },
                child: Text('Se connecter'),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 25, 61, 91),
                  minimumSize: Size(200, 50),
                ),
              ),
            ),
            SizedBox(height: 12.0),
            Text(
              _error,
              style: TextStyle(color: Color.fromARGB(255, 255, 17, 0)),
            ),
            SizedBox(height: 12.0),
            InkWell(
              child: Text(
                'Pas encore de compte ? Inscrivez-vous !',
                style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.underline,
                  color: Color.fromARGB(255, 25, 61, 91),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
