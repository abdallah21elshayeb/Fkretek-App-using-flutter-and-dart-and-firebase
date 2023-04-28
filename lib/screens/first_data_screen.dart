import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../models/language_const.dart';

import '../widgets/main_drawer.dart';
import '../widgets/head_of_page.dart';
import '../widgets/app_bar.dart';
import '../widgets/text_field_form.dart';
import '../widgets/thank_page.dart';

class FirstDataScreen extends StatefulWidget {
  static const routeName = '/first-idea';
  @override
  State<FirstDataScreen> createState() => _FirstDataScreenState();
}

class _FirstDataScreenState extends State<FirstDataScreen> {
//============== Firebase ref ===============================
  CollectionReference dataref =
      FirebaseFirestore.instance.collection('initialIdea');

//================== initial data ===========================
  Reference? ref;
  DatabaseReference? imgRef;
  final titleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final ideaController = TextEditingController();
  String? enteredTitle;
  late int enteredPhone;
  String? enteredEmail;
  String? enteredIdea;
  String? type;
  String? commercial;
  String? service;
  String? industrial;
  String? technology;
  late StreamSubscription subscription;
  bool hasInternet = false;
  bool isAlertSet = false;
  final _formKey = GlobalKey<FormState>();

//======================= Sumbit Data to Firebase =========================
  _submitData() async {
    enteredTitle = titleController.text;
    enteredPhone = int.parse(phoneController.text);
    enteredEmail = emailController.text;
    enteredIdea = ideaController.text;

    if (enteredTitle!.isEmpty ||
        enteredPhone.isNaN ||
        enteredEmail!.isEmpty ||
        enteredIdea!.isEmpty) {
      return;
    } else {
      print('-------------------------------');
      print('done');
    }

    await dataref.add({
      'name': enteredTitle,
      'phone': "+20" "$enteredPhone",
      'email': enteredEmail,
      'idea': enteredIdea,
      'ideaType': type,
    }).then((value) {
      print('================================');
      print('user added');
    }).catchError((e) {
      print('============================');
      print("$e");
    });
  }

// ===================== Interface ==========================
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
                                titleController,
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
                                phoneController,
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
                                emailController,
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
                                ideaController,
                                translation(context)!.idea,
                                translation(context)!.errorText,
                                10000,
                                3,
                                _submitData),

                            // =============== Type of Idea ===================
                            Container(
                              child: Column(
                                children: [
                                  Text(
                                    translation(context)!.ideaType1,
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
                          ],
                        ),
                      ),
                    ],
                  ),

                  //================ Submitted Button ===========================
                  Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.lightBlueAccent),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          } else {
                            _submitData();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ThankfulPage(),
                                ),
                                (Route<dynamic> route) => false);
                          }
                        },
                        child: Text(translation(context)!.submitInfo)),
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
