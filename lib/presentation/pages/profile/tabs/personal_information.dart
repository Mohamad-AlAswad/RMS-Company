import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rms_company/presentation/controllers/controllers.dart';

import '../../../controllers/personal_controllers.dart';
import 'profile_item_builder/profile_item_builder.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({
    Key? key,
    required this.personalControllers,

  }) : super(key: key);
  final PersonalControllers personalControllers;
  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  late List<TextEditingController> phones;
  late List<TextEditingController> emails;
  late List<String> genders;
  late String gender;
  late double rating;
  late PersonalControllers personalControllers;

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'failed to pick image');
    }
  }

  addPhone() {
    setState(() {
      phones.insert(phones.length, TextEditingController());
    });
  }

  removePhone(index) {
    setState(() {
      phones.removeAt(index);
    });
  }

  addEmail() {
    setState(() {
      emails.insert(emails.length, TextEditingController());
    });
  }

  removeEmail(index) {
    setState(() {
      emails.removeAt(index);
    });
  }


  chVal(value) {
    setState(() {
      gender = value;
    });
  }

  @override
  void initState() {
    super.initState();
    personalControllers = widget.personalControllers;
    phones = personalControllers.phones;
    emails = personalControllers.emails;

    genders = const ['Male', 'Female'];
    gender = personalControllers.gender;
    rating =  double.parse(personalControllers.rating);
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
          height: mq.size.height*1.5,
        ),
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
              ),
            ),
          ),
          child: ListView(
            primary: false,
            shrinkWrap: true,
            children: [
              const SizedBox(height: 15),
              Photo(
                image: image,
                pickImage: pickImage,
              ),
              const SizedBox(height: 15),
              Rating(rating: rating),
              const SizedBox(height: 15),
              FirstNameBuilder(personalControllers: personalControllers),
              MiddleNameBuilder(personalControllers: personalControllers),
              LastNameBuilder(personalControllers: personalControllers),
              EmailBuilder(personalControllers: personalControllers),
              // GenderBuilder(genders: genders, gender: gender, chVal: chVal),
              FreeSpaceBuilder(personalControllers: personalControllers),
              EmailList(emails: emails, add: addEmail, remove: removeEmail),
              PhoneList(phones: phones, add: addPhone, remove: removePhone),
            ],
          ),
        ),
      ),
    );
  }
}
