import 'package:first_flutter_project/common_widgets/alert_widget.dart';
import 'package:first_flutter_project/common_widgets/split_page_header_widget.dart';
import 'package:first_flutter_project/common_widgets/user_card_widget.dart';
import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/constants/common_constants.dart';
import 'package:first_flutter_project/models/split.dart';
import 'package:first_flutter_project/models/user.dart';
import 'package:first_flutter_project/pages/admin_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'qr_codes_page.dart';

class SplitPage extends StatefulWidget {
  const SplitPage(this.splitData, {super.key});

  final Split splitData;

  @override
  State<SplitPage> createState() => _SplitPageState();
}

class _SplitPageState extends State<SplitPage> {
  int touchedIndex = -1;
  double fadeOpacity = 1.0;

  @override
  void initState() {
    super.initState();
  }

  void navigateToScanQrCodePage(List<User> listOfUsers) {
    if (widget.splitData.leftToSplit > 0) {
      showDialog(
          context: context,
          builder: (context) => Alert(
              title: 'Split whole bill',
              description:
                  'Still € ${widget.splitData.leftToSplit.toStringAsFixed(2)} left to split!'));
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrCodesPage(listOfUsers),
      ),
    );
  }

  void onDragEnd(double sliderValue, int id) {
    setState(() {
      widget.splitData.calculateLefToPay(sliderValue, id);
      fadeOpacity = widget.splitData.leftToSplit <= 0 ? 0.5 : 1;
    });
  }

  void navigateToProfilePage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AdminDetailsPage(
            title: CommonConstants.editAdminTitle, buttonTitle: "EDIT"),
      ),
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
          "Split the bill",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ).animate().fade(begin: 0.5),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              navigateToProfilePage();
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: ColorsLibrary.appGray,
        child: SafeArea(
          child: Column(
            children: [
              SplitPageHeader(
                  users: widget.splitData.users,
                  totalBill: widget.splitData.bill,
                  leftToPay: widget.splitData.leftToSplit),
              Expanded(
                child: SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0, top: 0, right: 0, bottom: 40),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: widget.splitData.users.length,
                        itemBuilder: (BuildContext context, int index) {
                          User user = widget.splitData.users[index];
                          return CustomCard(
                            user: user,
                            onDragEnd: onDragEnd,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white.withOpacity(0.6),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ],
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .fade(
                              end: fadeOpacity,
                              delay: const Duration(milliseconds: 700)),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          {navigateToScanQrCodePage(widget.splitData.users)},
                      child: const Text('Generate QR code'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
