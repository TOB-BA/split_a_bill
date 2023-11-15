import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/database/database_service.dart';
import 'package:first_flutter_project/injection.dart';
import 'package:first_flutter_project/models/admin.dart';
import 'package:first_flutter_project/pages/home_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late Admin admin;
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _creditCardNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void setup() {
    getIt.registerSingleton<DatabaseService>(DatabaseService());
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _addressController.dispose();
    _emailAddressController.dispose();
    _creditCardNumberController.dispose();
    super.dispose();
  }

  bool checkIfEmailIsInValidForm(var email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool checkIfValueIsNullOrEmpty(var value) {
    return value == null || value.trim().isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Create your account",
          textAlign: TextAlign.center,
          style: TextStyle(color: ColorsLibrary.appGray),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white38,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _firstNameController,
                          autofocus: true,
                          validator: (value) {
                            if (checkIfValueIsNullOrEmpty(value)) {
                              return 'Please enter first name';
                            }
                          },
                          cursorColor: Colors.red.shade500,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'First name',
                          ),
                        ),
                        TextFormField(
                          controller: _lastNameController,
                          autofocus: true,
                          validator: (value) {
                            if (checkIfValueIsNullOrEmpty(value)) {
                              return 'Please enter last name';
                            }
                          },
                          cursorColor: Colors.red.shade500,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Last name',
                          ),
                        ),
                        TextFormField(
                          controller: _addressController,
                          validator: (value) {
                            if (checkIfValueIsNullOrEmpty(value)) {
                              return 'Please enter address';
                            }
                          },
                          autofocus: true,
                          cursorColor: Colors.red.shade500,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Address',
                          ),
                        ),
                        TextFormField(
                          controller: _emailAddressController,
                          validator: (value) {
                            if (checkIfValueIsNullOrEmpty(value)) {
                              return 'Please enter email address';
                            } else if (!checkIfEmailIsInValidForm(value)) {
                              return 'Email is not in valid form';
                            }
                          },
                          autofocus: true,
                          cursorColor: Colors.red.shade500,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Email address',
                          ),
                        ),
                        TextFormField(
                          controller: _creditCardNumberController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter card number';
                            }
                            if (value.length != 16) {
                              return 'Card number must contain 16 numbers';
                            }
                          },
                          autofocus: true,
                          cursorColor: ColorsLibrary.appGray,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Credit card number',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {navigateToHomePage()}
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsLibrary.appGreen,
                        ),
                        child: const Text(
                          "CREATE",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  navigateToHomePage() async {
    admin = Admin(
        id: 1,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailAddressController.text,
        address: _addressController.text,
        creditCardNumber: int.parse(_creditCardNumberController.text));

    await getIt<DatabaseService>().insertAdmin(admin);

    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(
          title: "We Split",
        ),
      ),
    );
  }
}
