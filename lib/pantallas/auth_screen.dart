import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1],
            )),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 94.0,
                      ),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Carolina Aguirre',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 50,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key? key,
  }) : super(key: key);
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
    'nombre': '',
    'apellido': ''
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _showErrorDial(String m) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Error'),
              content: Text(m),
              actions: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Entendido'))
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      //no valido
      return;
    }
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        //inicio sesion
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'] as String,
          _authData['password'] as String,
        );
      } else {
        //registrarse
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['nombre'] as String,
          _authData['apellido'] as String,
          _authData['email'] as String,
          _authData['password'] as String,
        );
      }
    } on HttpException catch (e) {
      var errorMessage = 'Autenticacion fallida';
      if (e.toString().contains('existe')) {
        errorMessage = 'El correo ingresado ya esta en uso';
        _showErrorDial(errorMessage);
      }
    } catch (error) {
      var errorMessage = 'Problemas en establecer conexion';
      _showErrorDial(errorMessage);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _swtichAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 320 : 260,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 320 : 260,
        ),
        width: devicesize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Correo Electronico',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Correo no valido!';
                      }
                      return null;
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value as String;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 4) {
                        return 'Contrase►a no valida';
                      }
                    },
                    onSaved: (value) {
                      _authData['password'] = value as String;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration:
                            InputDecoration(labelText: 'Confirmar Contraseña'),
                        obscureText: true,
                        //controller: _passwordController,
                        validator: _authMode == AuthMode.Signup
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Contraseña no valida(incorrecta)';
                                }
                              }
                            : null),
                  _authMode == AuthMode.Signup
                      ? TextFormField(
                          enabled: _authMode == AuthMode.Signup,
                          decoration: InputDecoration(
                            labelText: 'Nombre',
                          ),
                          //keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Nombre no valido!';
                            }
                            return null;
                            return null;
                          },
                          onSaved: (value) {
                            _authData['nombre'] = value as String;
                          },
                        )
                      : Text(''),
                  _authMode == AuthMode.Signup
                      ? TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Apellido',
                          ),
                          //keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Apellido no valido!';
                            }
                            return null;
                            return null;
                          },
                          onSaved: (value) {
                            _authData['apellido'] = value as String;
                          },
                        )
                      : Text(''),
                  SizedBox(
                    height: 30,
                  ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(_authMode == AuthMode.Login
                          ? 'Login'
                          : 'Registrarse'),
                    ),
                  TextButton(
                    onPressed: _swtichAuthMode,
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'REGISTRARSE' : 'LOGIN'} '),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
