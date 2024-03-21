import 'dart:io';
import 'package:easflow_v1/Controller/db_new.dart';

import 'package:easflow_v1/Widgets/button.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easflow_v1/Widgets/palette.dart';
import 'package:easflow_v1/Model/user_models.dart';
import 'package:easflow_v1/Controller/realtimr_data_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _TextController = TextEditingController();
  RealtimeDataController controller = RealtimeDataController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String path_image = '';
  String name = '';
  String email = '';
  String password = '';
  String role = '';

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future<String> saveimage(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/${path.basename(imageFile.path)}';
    final savedImage = await imageFile.copy(imagePath);
    return savedImage.path;
  }

  Future<void> _getimage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String imagePath = await saveimage(imageFile);
      setState(() {
        _image = imageFile;
        path_image = imagePath;
      });
    }
  }

  void createAccount(String nom, String image) async {
    String imagePath = path_image;
    if (_image != null && !imagePath.startsWith('assets')) {
      // Save the image file and get the saved path
      imagePath = await saveimage(_image!);
    }
    User newUser = User(
      username: nom,
      image: imagePath,
      emailaddress: email,
      password: password,
      role: role,
    );
    DatabaseHelper().addUser(newUser);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          ListView(children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 70),
                child: SizedBox(
                  height: 100,
                  child: Stack(
                    children: [
                      Image(image: AssetImage('assets/images/logo.png')),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
                padding:
                    EdgeInsets.only(top: 50, left: width / 7, right: width / 7),
                child: Container(
                  color: Colors.grey[
                      200], // Set your desired background color herechild:
                  child: TextField(
                    controller: _TextController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      labelStyle:
                          TextStyle(color: Palette.smaltBlue, fontSize: 18),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding:
                    EdgeInsets.only(top: 15, left: width / 7, right: width / 7),
                child: Container(
                  color: Colors.grey[
                      200], // Set your desired background color herechild:
                  child: TextField(
                    controller: _TextController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(50),
                    ],
                    maxLines: 1,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle:
                          TextStyle(color: Palette.smaltBlue, fontSize: 18),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Palette.apple, width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                  ),
                )),
            Padding(
              padding:
                  EdgeInsets.only(top: 15, left: width / 7, right: width / 7),
              child: Container(
                color: Colors
                    .grey[200], // Set your desired background color herechild:
                child: TextField(
                  controller: _TextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Mot de passe',
                    labelStyle:
                        TextStyle(color: Palette.smaltBlue, fontSize: 18),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 15, left: width / 7, right: width / 7),
              child: Container(
                color: Colors
                    .grey[200], // Set your desired background color herechild:
                child: TextField(
                  controller: _TextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                  maxLines: 1,
                  decoration: const InputDecoration(
                    labelText: 'Confirmer mot de passe',
                    labelStyle:
                        TextStyle(color: Palette.smaltBlue, fontSize: 18),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Palette.apple, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                    color: Palette.apple,
                    width: 180,
                    callback: () {
                      if (_TextController.text.isNotEmpty) {
                        createAccount(_TextController.text, "");
                        Navigator.pop(context);
                      }
                    },
                    content: const Center(
                        child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          color: Palette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    // Action à effectuer lors du clic sur le texte
                    // Par exemple, navigation vers la page de connexion
                  },
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        color: Palette.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        decoration:
                            TextDecoration.underline, // Ajouter le soulignement
                      ),
                      text: "Vous avez un compte ? ",
                      children: [
                        TextSpan(
                          text: "Connectez-vous",
                          style: TextStyle(
                            color: Palette.smaltBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration
                                .underline, // Ajouter le soulignement
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
