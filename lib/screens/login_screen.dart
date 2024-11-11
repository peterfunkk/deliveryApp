import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'OrdersScreen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isLoading = false;

  void _login() async {
  setState(() {
    _isLoading = true;
  });
  try {
    final response = await apiService.login(
      _usernameController.text,
      _passwordController.text,
    );

    // Utilizar la variable response (ejemplo: mostrar mensaje de bienvenida)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Bienvenido, ${response['username']}!")),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrdersScreen()),
    );
  } catch (error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error en login: $error")),
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _login,
                    child: Text('Iniciar Sesión'),

                  ),
                  // Agrega esto dentro de la columna principal en LoginScreen

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text("Crear una cuenta"),
                  ),

          ],
        ),
      ),
    );
  }

  
}
