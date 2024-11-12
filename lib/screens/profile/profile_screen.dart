import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:johndeereapp/consts.dart';
import 'package:johndeereapp/screens/profile/edit_profile.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/custom_bottom_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Francisco Tellez';
  String correo = '18030552@itcelaya.edu.mx';
  String tele = '412-173-7719';
  String gith = 'https://github.com/Drakho764';
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
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Mi Perfil',
                      style: GoogleFonts.josefinSans(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildAvatarSelector(),
                    Text(
                      name,
                      style: GoogleFonts.josefinSans(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      child: Text(
                        correo,
                        style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _makeSendMail(emails: correo);
                      },
                    ),
                    InkWell(
                      child: Text(
                        tele,
                        style: GoogleFonts.josefinSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _makePhoneCall(phoneNumber: tele);
                      },
                    ),
                    Link(
                      uri: Uri.parse(gith),
                      target: LinkTarget.blank,
                      builder: (BuildContext ctx, FollowLink? openLink) {
                        return TextButton.icon(
                          onPressed: openLink,
                          label: const Text('Github'),
                          icon: const Icon(Icons.web),
                        );
                      },
                    ),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 54, 124, 43),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => EditProfile(name)))
              .then((result) {
            if (result != null) {
              setState(() {
                name = result;
              });
            }
          });
        },
        child: Icon(
          Icons.edit,
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _makePhoneCall({required String phoneNumber}) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSendMail({required String emails}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emails,
    );
    await launchUrl(launchUri);
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
