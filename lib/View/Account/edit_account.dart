import 'package:flutter/material.dart';
import 'package:easflow_v1/Controller/db_new.dart';
import 'package:easflow_v1/Widgets/button.dart';
import 'package:flutter/services.dart';

import 'package:image_picker/image_picker.dart';
import 'package:easflow_v1/Widgets/palette.dart';
import 'package:easflow_v1/Model/user_models.dart';
import 'package:easflow_v1/Controller/realtimr_data_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<EditAccount> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  final TextEditingController _TextController = TextEditingController();
  RealtimeDataController controller = RealtimeDataController();
  int size = 0;
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String path_image = '';
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
    } else if (_image == null) {
      imagePath = "assets/images/avatars/user.png";
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
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: SizedBox(
                  height: 250,
                  child: Stack(
                    children: [
                      _image != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Palette.apple,
                                  width: 8,
                                ),
                              ),
                              child: CircleAvatar(
                                radius: 100,
                                backgroundColor: Palette.lightBlue,
                                backgroundImage: path_image.startsWith('assets')
                                    ? AssetImage(path_image) as ImageProvider
                                    : FileImage(_image!),
                              ))
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Palette.apple,
                                  width: 8,
                                ),
                              ),
                              child: const CircleAvatar(
                                radius: 100,
                                backgroundColor: Palette.white,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
                              ),
                            ),
                      Positioned(
                        bottom: 35,
                        right: 10,
                        child: Button(
                            callback: () {},
                            heigth: 60,
                            width: 60,
                            color: Palette.apple,
                            content: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Center(
                                          child: Text('Selectioner une image')),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          ListTile(
                                            leading: const Icon(
                                              Icons.camera_alt,
                                              color: Palette.smaltBlue,
                                            ),
                                            title:
                                                const Text('Depuis la camera'),
                                            onTap: () {
                                              _getimage(ImageSource.camera);
                                              Navigator.pop(context);
                                            },
                                          ),
                                          ListTile(
                                            leading: const Icon(
                                              Icons.image,
                                              color: Palette.blue,
                                            ),
                                            title: const Text(
                                                'Depuis la gallerie'),
                                            onTap: () {
                                              _getimage(ImageSource.gallery);
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                color: Palette.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 15, left: width / 7, right: width / 7),
              child: TextField(
                maxLength: 10,
                controller: _TextController,
                onChanged: (value) {
                  setState(() {});
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ],
                maxLines: 1,
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.edit_rounded,
                    color: Palette.lightBlue,
                    size: 30,
                  ),
                  labelText: 'Nom',
                  labelStyle:
                      const TextStyle(color: Palette.indigo, fontSize: 18),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.apple, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.lightBlue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.lightBlue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Palette.blue, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  errorText: _TextController.text.isEmpty
                      ? '*Le nom est obligatoire'
                      : null, // Add this line
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                    color: Palette.apple,
                    width: 180,
                    callback: () {
                      if (_TextController.text.isNotEmpty) {
                        createAccount(_TextController.text, "");
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Palette.pink,
                          content: Text(
                            'Le nom est obligatoire',
                            style:
                                TextStyle(color: Palette.white, fontSize: 18),
                          ),
                        ));
                      }
                    },
                    content: const Center(
                        child: Text(
                      "AJOUTER",
                      style: TextStyle(
                          color: Palette.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ))),
              ),
            )
          ]),
        ],
      ),
    );
  }
}
