import 'package:flutter/material.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _userController;
  late TextEditingController _passController;
  bool _obscureText = true;

  @override
  void initState() {
    _userController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _userController.dispose();
    _passController.dispose();
    super.dispose();
  }

  void loginValidation() {
    if (_formKey.currentState != null &&
        _formKey.currentState!.validate() &&
        _userController.text != '' &&
        _passController.text != '') {
      String username =
          _userController.text.substring(0, _userController.text.indexOf('@'));
      _passController.clear();
      _userController.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(userName: username)));
    }
  }

  @override
  Widget build(BuildContext context) {
    const appName =
        Text('News+', style: TextStyle(color: Colors.teal, fontSize: 20));
    final userId = TextFormField(
      controller: _userController,
      validator: (String? value) {
        if (value != null &&
            RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return null;
        }
        return 'Enter valid email id. eg.: abcd@gmail.com';
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Email Id",
        suffixIcon: IconButton(
          iconSize: 20,
          icon: const Icon(Icons.cancel),
          onPressed: () {
            _userController.clear();
            setState(() {});
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final passwordField = TextFormField(
      obscureText: _obscureText,
      validator: (String? value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return 'Password should not be empty';
      },
      controller: _passController,
      onEditingComplete: () {
        loginValidation();
      },
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          suffixIcon: IconButton(
            iconSize: 20,
            icon: const Icon(Icons.visibility),
            onPressed: () {
              _obscureText = _obscureText ? false : true;
              setState(() {});
            },
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        setState(() {
          loginValidation();
        });
      },
      child: const Text('Login'),
    );

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100.0,
                      child: Image.asset(
                        "assets/news_splash.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    appName,
                    const SizedBox(height: 15.0),
                    userId,
                    const SizedBox(height: 25.0),
                    passwordField,
                    const SizedBox(height: 25.0),
                    loginButton,
                    const SizedBox(height: 15.0),
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
