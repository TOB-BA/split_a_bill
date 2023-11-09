import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodesPage extends StatefulWidget {
  const QrCodesPage(this.users, {super.key});
  final List<User> users;
  @override
  State<QrCodesPage> createState() => _QrCodesPageState();
}

class _QrCodesPageState extends State<QrCodesPage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsLibrary.appGray,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
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
                Container(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter your URL'),
                  ),
                ),
                //This button when pressed navigates to QR code generation
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: widget.users?.length,
                    itemBuilder: (BuildContext context, int index) {
                      User user = widget.users[index];
                      if (user.priceToPay > 0) {
                        return Column(
                          children: [
                            Text(
                              user.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            const SizedBox(height: 10),
                            QrImageView(
                              backgroundColor: Colors.white,
                              data: '${user.priceToPay}',
                              version: QrVersions.auto,
                              padding: EdgeInsets.all(34),
                            ),
                            const SizedBox(height: 30),
                          ],
                        );
                      } else {
                        return SizedBox();
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
