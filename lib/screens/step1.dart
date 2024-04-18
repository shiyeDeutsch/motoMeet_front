import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:motomeetfront/models/userModel.dart';

import '../routing/routes.dart';
import '../services/authService.dart';
import '../services/isar_service.dart';
import '../widgets/customTextFromField.dart';
import '../widgets/dropdown.dart';

class Step1Screen extends StatefulWidget {
  Step1Screen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String email;
  final String password;

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  final fNameController = TextEditingController();

  final lNameController = TextEditingController();
  final dateController = TextEditingController();
  final auth = GetIt.I<AuthenticationService>();
  DateTime selectedDate = DateTime.now() ;
  final _formKey = GlobalKey<FormState>();
  late int countryId;
  String data = '';
  List<DropdownMenuItem> menuItems = <DropdownMenuItem<dynamic>>[];

  final cityController = TextEditingController();
  @override
  void initState() {
    String filePath =
        'C:\\src\\Flutter\\motoMeetFront\\motomeetfront\\assets\\country.json';
    data = File(filePath).readAsStringSync();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextFromField(
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Please enter a first name ';
                  } else {
                    return null;
                  }
                },
                controller: fNameController,
                hintText: 'first name'),
            const SizedBox(height: 16),
            CustomTextFromField(
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Please enter a last name ';
                  } else {
                    return null;
                  }
                },
                controller: lNameController,
                hintText: 'Last name'),
            const SizedBox(height: 16),

            CustomTextFromField(
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter your date of birth';
                } else {
                  return null;
                }
              },
              controller: dateController,
              readOnly: true,
              hintText: 'Tap to select date',
              onTap: () => selectDate(context),
            ),
            const SizedBox(height: 16),
            conutry(),
            const SizedBox(height: 16),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'City/Region',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: regist,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Widget conutry() {
    menuItems.clear();

    List<dynamic> countries = json.decode(data);

    for (var element in countries) {
      menuItems.add(
        DropdownMenuItem(
          value: element['Id'] as int,
          child: Text(element['Name']),
        ),
      );
    }
    return CustomDropdown(
      dropdownMenuEntries: menuItems,
      inputDecorationTheme: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          //  gapPadding: 4,
        ),
        hintText: 'select your contry',
      ),
      onSelected: (value) {
        countryId = value;

        if (kDebugMode) {
          print("Selected country value: $value");
        }
      },
    );
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1930),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        var date = DateFormat('yyyy.MM.dd').format(selectedDate);
        dateController.text = date;
      });
    }
  }

  Future<void> regist() async {
    if (_formKey.currentState!.validate()) {
      var user = UserInfo(
        email: widget.email,
        password: widget.password,
        firstName: fNameController.text,
        lastName: lNameController.text,
        age: 0,
        countryId: countryId,
      );
      final newUser = await auth.register(user);

      if (newUser != null) {
        final isarService = GetIt.I<IsarService>();
        await isarService.addUser(newUser);

        Navigator.of(context).pushNamed(Routes.homePage);
      }
    }
  }
}
