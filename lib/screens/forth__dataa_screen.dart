import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fkrety/widgets/thank_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_database/firebase_database.dart';

import '../models/language_const.dart';
import '../widgets/firebase_api.dart';
import '../widgets/main_drawer.dart';
import '../widgets/app_bar.dart';
import '../widgets/head_of_page.dart';
import '../widgets/image_input.dart';
import '../widgets/text_field_form.dart';
import '../widgets/upload_progress.dart';

class ForthDataaScreen extends StatefulWidget {
  static const routeName = '/forth-idea';

  @override
  State<ForthDataaScreen> createState() => _ForthDataaScreenState();
}

CollectionReference dataref =
    FirebaseFirestore.instance.collection('existingCompany');

class _ForthDataaScreenState extends State<ForthDataaScreen> {
//===============Constants==========================

  final _titleController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _visionController = TextEditingController();
  final _missionController = TextEditingController();
  final _goalsController = TextEditingController();
  final _productsController = TextEditingController();
  final _salesController = TextEditingController();

  String? enteredTitle;
  late int enteredPhone;
  String? enteredEmail;
  String? enteredVision;
  String? enteredMission;
  String? enteredGoals;
  String? enteredProduct;
  String? enteredSales;
  String? type;
  PlatformFile? pickedFile;
  String? fileUrl;
  String? imageurl;
  UploadTask? task;
  DatabaseReference? imgRef;
  late firebase_storage.Reference ref;
  List<String> imageUrl = [];

  final _formKey = GlobalKey<FormState>();

//==============uplaed progress================================

  Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final progress = snap.bytesTransferred / snap.totalBytes;
            final percentage = (progress * 100).ceilToDouble();

            return UploadProgress(progress: progress, precentage: percentage);
          } else {
            return Container();
          }
        },
      );

//============ File select Function to UI==========================
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

//===============File upload Function to Firebase=====================
  Future uploadFile() async {
    final path = 'files/ ${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        fileUrl = value;

        print('========================----==============');
        print(value);
        print('========================----==============');
        print(fileUrl);
      });
    });
    task = FirebaseApi.uploadFile(path, file);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
  }

//======================= Sumbit Data to Firebase =========================
  void _submitData() async {
    enteredTitle = _titleController.text;
    enteredPhone = int.parse(_phoneController.text);
    enteredEmail = _emailController.text;
    enteredVision = _visionController.text;
    enteredMission = _missionController.text;
    enteredGoals = _goalsController.text;
    enteredProduct = _productsController.text;
    enteredSales = _salesController.text;

    if (enteredTitle!.isEmpty ||
        enteredPhone.isNaN ||
        enteredEmail!.isEmpty ||
        enteredVision!.isEmpty ||
        enteredMission!.isEmpty ||
        enteredGoals!.isEmpty ||
        enteredProduct!.isEmpty ||
        enteredSales!.isEmpty) {
      return;
    } else {
      print('-------------------------------');
      print('done');
    }

    await dataref.add({
      'name': enteredTitle,
      'phone': "+20" "$enteredPhone",
      'email': enteredEmail,
      'vission': enteredVision,
      'mission': enteredMission,
      'goals': enteredGoals,
      'product': enteredProduct,
      'sales': enteredSales,
      'imageurl': imageUrl,
      'fileUrl': fileUrl,
      'ideaType': type,
    }).then((value) {
      print('================================');
      print('user added');
    }).catchError((e) {
      print('============================');
      print("$e");
    });
  }

// ==========================image functions===========================

  final picker = ImagePicker();

  final List<File> image = [];

// ====================functions========================================

  chooseImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      image.add(File(PickedFile!.path));
    });
    if (PickedFile?.path == null) retrieveLostData();
  }

  Future retrieveLostData() async {
    final LostData response = await picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        image.add(File(response.file!.path));
      });
    } else {
      print(response.file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context) as PreferredSizeWidget?,
      drawer: MainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  headOfPage(context),
                  Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFieldForm(
                                context,
                                TextInputType.name,
                                _titleController,
                                translation(context)!.name,
                                translation(context)!.errorName,
                                null,
                                1,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.phone,
                                _phoneController,
                                translation(context)!.phone,
                                translation(context)!.errorPhone,
                                null,
                                1,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.emailAddress,
                                _emailController,
                                translation(context)!.emailHint,
                                translation(context)!.errorEmail,
                                null,
                                1,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.text,
                                _visionController,
                                translation(context)!.vision,
                                translation(context)!.errorText,
                                2000,
                                3,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.text,
                                _missionController,
                                translation(context)!.mission,
                                translation(context)!.errorText,
                                5000,
                                3,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.text,
                                _goalsController,
                                translation(context)!.goals,
                                translation(context)!.errorText,
                                5000,
                                3,
                                _submitData),
                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.text,
                                _productsController,
                                translation(context)!.productDetails,
                                translation(context)!.errorText,
                                5000,
                                3,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),
                            TextFieldForm(
                                context,
                                TextInputType.text,
                                _salesController,
                                translation(context)!.sales,
                                translation(context)!.errorText,
                                5000,
                                3,
                                _submitData),
                            SizedBox(
                              height: 20,
                            ),

                            // =============== Type of Idea ===================
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    translation(context)!.ideaType4,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlue),
                                  ),
                                  RadioListTile(
                                      title:
                                          Text(translation(context)!.service),
                                      value: translation(context)!.service,
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value.toString();
                                        });
                                      }),
                                  RadioListTile(
                                      title: Text(
                                          translation(context)!.commercial),
                                      value: translation(context)!.commercial,
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value.toString();
                                        });
                                      }),
                                  RadioListTile(
                                      title: Text(
                                          translation(context)!.industrial),
                                      value: translation(context)!.industrial,
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value.toString();
                                        });
                                      }),
                                  RadioListTile(
                                      title:
                                          Text(translation(context)!.tecnology),
                                      value: translation(context)!.tecnology,
                                      groupValue: type,
                                      onChanged: (value) {
                                        setState(() {
                                          type = value.toString();
                                        });
                                      })
                                ],
                              ),
                            ),
                            // =========================image input===========================
                            Text(
                              translation(context)!.moreImages,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 150,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: GridView.builder(
                                        itemCount: image.length + 1,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 3,
                                          crossAxisSpacing: 2,
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return index == 0
                                              ? Center(
                                                  child: IconButton(
                                                      icon:
                                                          const Icon(Icons.add),
                                                      onPressed: () async {
                                                        chooseImage();
                                                      }),
                                                )
                                              : Container(
                                                  margin:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              image[index - 1]),
                                                          fit: BoxFit.cover)),
                                                );
                                        }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: FlatButton.icon(
                                    icon: Icon(Icons.camera),
                                    label: Text(translation(context)!.addImage),
                                    textColor: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      chooseImage();
                                    },
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            //=================== File Input=========================
                            Text(
                              translation(context)!.moreFiles,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.lightBlue),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                if (pickedFile != null)
                                  Container(
                                    height: 50,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1, color: Colors.grey),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(pickedFile!.name),
                                    ),
                                  ),
                                Expanded(
                                    child: FlatButton.icon(
                                  onPressed: () {
                                    selectFile();
                                  },
                                  icon: Icon(Icons.insert_drive_file),
                                  label: Text(translation(context)!.fileName),
                                  textColor: Theme.of(context).primaryColor,
                                ))
                              ],
                            ),
                            // ===============upload progress============================
                            SizedBox(height: 20),
                            task != null
                                ? buildUploadStatus(task!)
                                : Container(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //================ Submitted Button ===========================
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        } else {
                          uploadFile();
                          // ===============upload image function=================
                          UploadImage.submit(
                                  image: image,
                                  imgRef: imgRef,
                                  myList: imageUrl)
                              // ==============upload all data function===================
                              .whenComplete(_submitData)
                              .whenComplete(() => Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ThankfulPage(),
                                  ),
                                  (Route<dynamic> route) => false));
                        }
                      },
                      child: Text(translation(context)!.submitInfo),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightBlueAccent),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
