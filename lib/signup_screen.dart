import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:johndeereapp/consts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _controller = TextEditingController();
    final _controller0 = TextEditingController();
      final _controller1 = TextEditingController();
  bool _validate = false;

  @override
  void dispose() {
    _controller.dispose();
    _controller0.dispose();
    _controller1.dispose();
    super.dispose();

  }
  String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}
  File? _userAvatar;
  final btncolorr=btnColor;
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _userAvatar = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Error al seleccionar o capturar la imagen: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ), // AppBar
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Sign Up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    ),
              ),
              const SizedBox(height: 60),
              _buildAvatarSelector(),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.center,
                  controller: _controller,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Ingresa un email" : null,
                    hintText: "Enter email or username",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  controller: _controller0,
                  obscureText: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Value Can't Be Empty" : null,
                    hintText: "Enter your Password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.withOpacity(0.2)),
                child: TextField(
                  controller: _controller1,
                  obscureText: true,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.lock,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Value Can't Be Empty" : null,
                    hintText: "Confirm your Password",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
           /*   Container(
                  width: 400,
                  height: 50,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12), color: btnColor),
                  child: Text("Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))),*/
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor:btnColor),
                onPressed: () {
                  setState(() {
                    _validate = _controller.text.isEmpty;
                  });
                },
                child: const Text('Sing up',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Caray, ya tienes una cuenta?",
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: btnColor, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ],
          ),
        ), // Column
      ), // Container
    );
  }

  Widget _buildAvatarSelector() {
    return Column(
      children: [
        _userAvatar != null
            ? CircleAvatar(
                radius: 85.0,
                backgroundImage: FileImage(_userAvatar!),
              )
            : const CircleAvatar(
                radius: 50.0,
                child: Icon(Icons.person),
              ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: btnColor),
              onPressed: () => _pickImage(ImageSource.gallery),
              child: const Text('Galería',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            ),
            const SizedBox(width: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: btnColor),
              onPressed: () => _pickImage(ImageSource.camera),
              child: const Text('Cámara',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
            ),
          ],
        ),
      ],
    );
  }
}
