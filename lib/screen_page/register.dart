import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_register.dart';
import 'package:uts_mobile2_app/screen_page/login.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nimController = TextEditingController();
  final _passwordController = TextEditingController();
  final _namaController = TextEditingController();
  bool _obscurePassword = true; // State untuk mengontrol visibilitas password
  bool isLoading = false;

  Future<ModelRegister?> registerAccount() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        http.Response res =
            await http.post(Uri.parse('${url}register.php'), body: {
          "username": _usernameController.text,
          "nama": _namaController.text,
          "nobp": _nimController.text,
          "email": _emailController.text,
          "password": _passwordController.text,
        });
        print(_usernameController.text);
        print(_namaController.text);
        print(_emailController.text);
        print(_nimController.text);
        print(_passwordController.text);
        final data = modelRegisterFromJson(res.body);

        if (data.value == 1) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false,
          );
        }

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data.message)));
      } catch (e) {
        print(e.toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _usernameController.dispose();
    _nimController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('./assets/LogoDua.png', width: 1000),
                SizedBox(height: 20.0),
                Text(
                  'Daftar',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan email Anda';
                    } else if (!value.contains('@')) {
                      return 'Masukkan email yang valid';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan nama Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan username Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _nimController,
                  decoration: InputDecoration(
                    labelText: 'NIM',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan NIM Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan password Anda';
                    } else if (value.length < 3) {
                      return 'Password harus memiliki minimal 6 karakter';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  onPressed: () {
                    registerAccount();
                  },
                  color: Colors.green.shade300,
                  disabledColor: Colors.grey,
                  textColor: Colors.white,
                  height: 45,
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Register'),
                ),
                SizedBox(height: 20.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Sudah punya akun? Masuk'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
