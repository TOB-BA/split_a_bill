import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/database/database_service.dart';
import 'package:first_flutter_project/injection.dart';
import 'package:first_flutter_project/models/admin.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../models/qr_data.dart';

class QrCodesPage extends StatefulWidget {
  const QrCodesPage(this.users, {super.key});
  final List<User> users;
  @override
  State<QrCodesPage> createState() => _QrCodesPageState();
}

class _QrCodesPageState extends State<QrCodesPage> {
  TextEditingController controller = TextEditingController();

  Future<Admin> getAdmin() async {
    return (await getIt<DatabaseService>().getAdmin())[0];
  }

  Future<PaymentData> getQrdDta(User user) async {
    Admin admin = await getAdmin();
    return PaymentData(
      userId: user.id,
      firstName: admin.firstName,
      lastName: admin.lastName,
      address: admin.address,
      cardNumber: admin.creditCardNumber,
      priceToPay: user.priceToPay,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.appGray,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        iconTheme: const IconThemeData(color: Colors.white, size: 30),
        title: const Text(
          "Select your QR code",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorsLibrary.appGray,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = widget.users[index];
                      if (user.priceToPay > 0) {
                        return Column(
                          children: [
                            Text(
                              "${user.name} - € ${user.priceToPay.toStringAsFixed(2)}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            FutureBuilder<PaymentData>(
                              future: getQrdDta(user),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  PaymentData? paymentData = snapshot.data;
                                  String? firstName = paymentData?.firstName;
                                  String? lastName = paymentData?.lastName;
                                  String? address = paymentData?.address;
                                  String? cardNumber =
                                      paymentData?.cardNumber.toString();
                                  String? priceToPay =
                                      paymentData?.priceToPay.toString();
                                  return QrImageView(
                                    backgroundColor: Colors.white,
                                    data:
                                        '$firstName $lastName \n$address\n$cardNumber\n$priceToPay',
                                    version: QrVersions.auto,
                                    padding: const EdgeInsets.all(34),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
