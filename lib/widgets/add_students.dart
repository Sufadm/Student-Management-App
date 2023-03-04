import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../db/functions/db_functions.dart';
import '../model/data_model.dart';

class AddStudentClass extends StatefulWidget {
  const AddStudentClass({Key? key}) : super(key: key);

  @override
  State<AddStudentClass> createState() => _AddStudentClassState();
}

class _AddStudentClassState extends State<AddStudentClass> {
  final _nameOfStudent = TextEditingController();
  final _ageOfStudent = TextEditingController();
  final _addressOfStudent = TextEditingController();
  final _phoneNumber = TextEditingController();
  bool imageAlert = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Add Student details',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _photo?.path == null
                    ? const CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/premium-vector/avatar-portrait-kid-caucasian-boy-round-frame-vector-illustration-cartoon-flat-style_551425-43.jpg'),
                        // backgroundColor: Color.fromARGB(255, 154, 137, 81),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(
                          File(
                            _photo!.path,
                          ),
                        ),
                        radius: 60,
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: (Colors.black)),
                      onPressed: () {
                        getPhoto();
                      },
                      icon: const Icon(
                        Icons.image_outlined,
                      ),
                      label: const Text(
                        'Add An Image',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _nameOfStudent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Enter student Name',
                      labelText: 'Name',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Name is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _ageOfStudent,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Enter age',
                      labelText: 'age',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Age is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _addressOfStudent,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Enter address',
                      labelText: 'Address',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' Address is Required';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLength: 10,
                  controller: _phoneNumber,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)),
                      hintText: 'Enter the number',
                      labelText: 'Number',
                      labelStyle: TextStyle(fontStyle: FontStyle.italic)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Number is Required';
                    } else if (value.length < 10) {
                      return 'invalid phone number';
                    } else {
                      return null;
                    }
                  },
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: (Colors.black)),
                    onPressed: (() {
                      if (_formKey.currentState!.validate() && _photo != null) {
                        onStudentAddButtonClick();
                        Navigator.of(context).pop();
                      } else {
                        imageAlert = true;
                      }
                    }),
                    icon: const Icon(Icons.add),
                    label: const Text('Add student'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onStudentAddButtonClick() async {
    final name = _nameOfStudent.text.trim();
    final age = _ageOfStudent.text.trim();
    final address = _addressOfStudent.text.trim();
    final number = _phoneNumber.text.trim();

    if (_photo!.path.isEmpty ||
        name.isEmpty ||
        age.isEmpty ||
        address.isEmpty ||
        number.isEmpty) {
      return;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(20),
          content: Text(
            "Student Added Successfully,",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
    }
    stdout.write('$name $age $number $address');
    final student = StudentModel(
        name: name,
        age: age,
        address: address,
        phnNumber: number,
        photo: _photo!.path);

    addStudent(student);
  }

  File? _photo;
  Future<void> getPhoto() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) {
      return;
    } else {
      final photoTemp = File(photo.path);
      setState(
        () {
          _photo = photoTemp;
        },
      );
    }
  }
}
