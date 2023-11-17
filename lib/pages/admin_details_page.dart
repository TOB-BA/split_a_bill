import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/constants/common_constants.dart';
import 'package:first_flutter_project/database/database_service.dart';
import 'package:first_flutter_project/injection.dart';
import 'package:first_flutter_project/models/admin.dart';
import 'package:first_flutter_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AdminDetailsPage extends StatefulWidget {
  final String title;
  final String buttonTitle;

  const AdminDetailsPage(
      {super.key, required this.title, required this.buttonTitle});

  @override
  State<AdminDetailsPage> createState() => _AdminDetailsPageState();
}

class _AdminDetailsPageState extends State<AdminDetailsPage> {
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
    if (widget.title == CommonConstants.editAdminTitle) {
      getAdmin();
    }
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
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  bool checkIfValueIsNullOrEmpty(var value) {
    return value == null || value.trim().isEmpty;
  }

  Future<void> getAdmin() async {
    admin = (await getIt<DatabaseService>().getAdmin())[0];

    _firstNameController.text = admin.firstName;
    _lastNameController.text = admin.lastName;
    _emailAddressController.text = admin.email;
    _addressController.text = admin.address;

    var adminCreditCardNumberAsString = admin.creditCardNumber.toString();

    _creditCardNumberController.text =
        "${adminCreditCardNumberAsString.substring(0, 3)}-"
        "${adminCreditCardNumberAsString.substring(3, 14)}-"
        "${adminCreditCardNumberAsString.substring(14)}";
  }

  mainButtonPressed() async {
    admin = Admin(
      id: 1,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      email: _emailAddressController.text,
      address: _addressController.text,
      creditCardNumber: int.parse(
        _creditCardNumberController.text
            .replaceAll("-", CommonConstants.emptyString),
      ),
    );

    widget.title == CommonConstants.editAdminTitle
        ? await navigateFromProfilePage(admin)
        : await navigateToHomePage(admin);
  }

  navigateToHomePage(Admin createdAdmin) async {
    await getIt<DatabaseService>().insertAdmin(createdAdmin);

    // ignore: use_build_context_synchronously
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const MyHomePage(
          title: CommonConstants.homePageTitle,
        ),
      ),
    );
  }

  navigateFromProfilePage(Admin updatedAdmin) async {
    await getIt<DatabaseService>().updateAdmin(updatedAdmin);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          widget.title,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      autofocus: true,
                      validator: (value) {
                        if (checkIfValueIsNullOrEmpty(value)) {
                          return 'Please enter first name';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: ColorsLibrary.appGray,
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
                        } else {
                          return null;
                        }
                      },
                      cursorColor: ColorsLibrary.appGray,
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
                        } else {
                          return null;
                        }
                      },
                      autofocus: true,
                      cursorColor: ColorsLibrary.appGray,
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
                        } else {
                          return null;
                        }
                      },
                      autofocus: true,
                      cursorColor: ColorsLibrary.appGray,
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
                        if (value.length != 18) {
                          return 'Card number must contain 16 numbers';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: "###-###########-##",
                          filter: {"#": RegExp(r'[0-9]')},
                        ),
                      ],
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
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () => {
              if (_formKey.currentState!.validate()) {mainButtonPressed()}
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsLibrary.appGreen,
            ),
            child: Text(
              widget.buttonTitle,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
