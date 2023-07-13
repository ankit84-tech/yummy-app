import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:yummy_app/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcont = TextEditingController();
  final TextEditingController _passcont = TextEditingController();
  bool isLogin = true;
  String errorMsg = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isLogin ? "Login" : "Signin",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 32)),
            Text(errorMsg,
            style: TextStyle(
              color: Colors.red[300]
            ),),
            const SizedBox(
              height: 30,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "your@email.com",
                border: OutlineInputBorder(),
                label: Text("Email")
              ),
              controller: _emailcont,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: "some unique pass",
                border: OutlineInputBorder(),
                label: Text("Password")
              ),
              controller: _passcont,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {authenticate(context);}, child: const Text("Continue")),
            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                    errorMsg = "";
                  });
                },
                child: Text(isLogin
                    ? "Signin, if new here"
                    : "Login, if already have account"))
          ],
        ),
      ),
    );
  }

  authenticate(BuildContext context) async {
    if (_emailcont.text == "" || _passcont.text == "") {
      const SnackBar(
        content: Text("both fields are required!"),
      );
      return;
    }
    try {
      if (isLogin) {
        await AuthService()
            .signinWithEmainPass(email: _emailcont.text, pass: _passcont.text);
      } else {
        await AuthService()
            .createWithEmainPass(email: _emailcont.text, pass: _passcont.text);
      }
      Navigator.of(context)
      .popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMsg = e.message!;
      });
    }
  }
}
