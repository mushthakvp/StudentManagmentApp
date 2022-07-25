import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_model/core/const/colors.dart';
import 'package:student_model/core/style/style.dart';
import 'package:student_model/domain/add/addphoto.dart';
import 'package:student_model/domain/home/model/home_model.dart';
import 'package:student_model/infrastructure/home/home_impliment.dart';

// ignore: must_be_immutable
class AddScreen extends StatelessWidget {
  final ActionType type;
  final bool visible;
  final HomeModel? data;
  AddScreen({
    Key? key,
    required this.type,
    required this.visible,
    this.data,
  }) : super(key: key);

  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _placeController = TextEditingController();

  String title = '';
  String buttonText = '';
  @override
  Widget build(BuildContext context) {
    checkScreenInfo();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: lightGreenColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            title,
            style: sFont(color: whiteColor),
          ),
        ),
        body: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 50),
            type == ActionType.add ? const ImageWidget() : ImageWidgetEdit(data: data),
            const SizedBox(
              height: 40,
            ),
            TextFieldsWidget(
              icon: Icons.person,
              hint: 'Name',
              controllerText: _nameController,
              type: TextInputType.name,
            ),
            TextFieldsWidget(
              icon: Icons.person_pin_circle,
              hint: 'Place',
              controllerText: _placeController,
              type: TextInputType.name,
            ),
            TextFieldsWidget(
              icon: Icons.phone,
              hint: 'Number',
              controllerText: _phoneController,
              type: TextInputType.number,
            ),
            TextFieldsWidget(
              icon: Icons.person_sharp,
              hint: 'Age',
              controllerText: _ageController,
              type: TextInputType.number,
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(14, 5, 14, 5),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: ofColor,
                      onPressed: () {
                        checkButton(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        child: Text(
                          buttonText,
                          style: sFont(color: greenColor),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: visible,
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: ofColor,
                          onPressed: () {
                            deleteData(context, data!.id);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 20,
                            ),
                            child: Text(
                              'Delete',
                              style: sFont(color: redColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkScreenInfo() {
    if (type == ActionType.add) {
      title = 'AddScreen';
      buttonText = 'Submit';
    } else {
      title = 'EditScreen';
      buttonText = 'Update';
      _ageController.text = data!.age;
      _nameController.text = data!.name;
      _placeController.text = data!.place;
      _phoneController.text = data!.number;
    }
  }

  checkButton(context) {
    switch (type) {
      case ActionType.edit:
        upDateData(context);
        break;
      case ActionType.add:
        addData(context);
        break;
    }
  }

  void addData(context) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final number = _phoneController.text;

    if (place.isEmpty || age.isEmpty || name.isEmpty || number.isEmpty || Provider.of<AddPhotoPov>(context, listen: false).imageToString.trim().isEmpty) {
      return;
    }

    final data = HomeModel(
      id: id,
      name: name,
      place: place,
      number: number,
      age: age,
      image: Provider.of<AddPhotoPov>(context, listen: false).imageToString,
    );
    HomeImpl().addDetails(data);

    await Provider.of<HomeImpl>(context, listen: false).getAllDetails();
    Provider.of<AddPhotoPov>(context, listen: false).imageToString = '';
    Navigator.of(context).pop();
  }

  void upDateData(context) async {
    final name = _nameController.text;
    final age = _ageController.text;
    final place = _placeController.text;
    final number = _phoneController.text;

    if (place.isEmpty || age.isEmpty || name.isEmpty || number.isEmpty) {
      return;
    }

    final dataFinal = HomeModel(
      id: data!.id,
      name: name,
      place: place,
      number: number,
      age: age,
      image: Provider.of<AddPhotoPov>(context, listen: false).imageToString.trim().isEmpty ? data!.image : Provider.of<AddPhotoPov>(context, listen: false).imageToString,
    );
    HomeImpl().updateDetails(dataFinal);
    await Provider.of<HomeImpl>(context, listen: false).getAllDetails();
    Provider.of<AddPhotoPov>(context, listen: false).imageToString = '';
    Navigator.of(context).pop();
  }

  void deleteData(BuildContext context, String value) {
    Provider.of<HomeImpl>(context, listen: false).deleteDetails(value);
    Navigator.of(context).pop();
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AddPhotoPov>(context, listen: false).pickImage();
      },
      child: Consumer<AddPhotoPov>(
        builder: (BuildContext context, value, Widget? child) {
          return value.imageToString.trim().isEmpty
              ? const CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 70,
                  backgroundImage: AssetImage(
                    'asset/student.jpg',
                  ),
                )
              : CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 70,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(value.imageToString),
                  ),
                );
        },
      ),
    );
  }
}

class ImageWidgetEdit extends StatelessWidget {
  final HomeModel? data;
  const ImageWidgetEdit({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AddPhotoPov>(context, listen: false).pickImage();
      },
      child: Consumer<AddPhotoPov>(
        builder: (BuildContext context, value, Widget? child) {
          return value.imageToString.trim().isEmpty
              ? CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 70,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(data!.image),
                  ),
                )
              : CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 70,
                  backgroundImage: MemoryImage(
                    const Base64Decoder().convert(value.imageToString),
                  ),
                );
        },
      ),
    );
  }
}

enum ActionType { edit, add }

class TextFieldsWidget extends StatelessWidget {
  const TextFieldsWidget({
    Key? key,
    required this.icon,
    required this.hint,
    required this.controllerText,
    required this.type,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final TextEditingController controllerText;
  final dynamic type;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 5, 14, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ofColor, border: Border.all(color: ofColor)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: greenColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Icon(
              icon,
              color: whiteColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Center(
              child: TextFormField(
                maxLength: type == TextInputType.number ? 12 : 20,
                keyboardType: type,
                controller: controllerText,
                cursorColor: greenColor,
                style: const TextStyle(
                  fontSize: 18,
                  color: blackColor,
                ),
                decoration: InputDecoration(
                    counterText: '',
                    hintStyle: const TextStyle(
                      fontSize: 18,
                      color: blackColor,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: hint),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .88,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: greenColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // <-- Radius
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Text(
            'SUBMIT',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'redhat',
            ),
          ),
        ),
      ),
    );
  }
}
