import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/screens/profile/widgets/custom_bottom_bar.dart';

class EditProfile extends StatefulWidget {
  String name;
  EditProfile(this.name);
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _controller = TextEditingController();
    final _controller0 = TextEditingController();
      final _controller1 = TextEditingController();
  bool _validate = false;
  late TextEditingController _controller2;
  @override
  void initState() {
    _controller2 =TextEditingController(text: widget.name);
    super.initState();
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
                "Editar Perfil",
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
                  controller: _controller2,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Ingresa tu Nombre" : null,
                    hintText: "Name",
                    border: InputBorder.none,
                  ),
                ),
              ),
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
                    hintText: "Email",
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
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.phone,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Value Can't Be Empty" : null,
                    hintText: "Phone",
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
                      Icons.gite,
                      color: btnColor,
                    ),
                    errorText: _validate ? "Value Can't Be Empty" : null,
                    hintText: "Github",
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
            
                ],
              ),
          ),
        ),
        bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor:  Color.fromARGB(255, 54, 124, 43),
        onPressed: () {
          Navigator.of(context).pop(_controller2.text);
        },
        child: Icon(
          Icons.save,
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, // Column
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