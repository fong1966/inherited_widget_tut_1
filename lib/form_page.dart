import 'package:flutter/material.dart';
import 'package:inherited_widget_tut_1/state_container.dart';

class UpdateUserScreen extends StatelessWidget {
  UpdateUserScreen({super.key});

  static const route = "/route";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> firstNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> lastNameKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> emailKey =
      GlobalKey<FormFieldState<String>>();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = StateContainer.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: ListView(
            children: [
              TextFormField(
                key: firstNameKey,
                controller: firstName,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //allow upper and lower case alphabets and space
                    return "Enter Correct Name";
                  } else {
                    return null;
                  }
                },
                style: Theme.of(context).textTheme.headlineLarge,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
              ),
              TextFormField(
                key: lastNameKey,
                controller: lastName,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                    //allow upper and lower case alphabets and space
                    return "Enter Correct Name";
                  } else {
                    return null;
                  }
                },
                style: Theme.of(context).textTheme.headlineLarge,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
              ),
              TextFormField(
                key: emailKey,
                controller: email,
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter Correct Email Address";
                  } else {
                    return null;
                  }
                },
                style: Theme.of(context).textTheme.headlineLarge,
                decoration: const InputDecoration(
                  hintText: 'Email Address',
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          final form = formKey.currentState;
          if (form!.validate()) {
            firstName.text = firstNameKey.currentState!.value as String;
            lastName.text = lastNameKey.currentState!.value as String;
            email.text = emailKey.currentState!.value as String;

            userData.updateUserInfo(
                firstName: firstName.text,
                lastName: lastName.text,
                email: email.text);

            // Later, do some stuff here

            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
