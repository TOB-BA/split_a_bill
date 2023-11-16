import 'package:first_flutter_project/constants/colors/colors_library.dart';
import 'package:first_flutter_project/constants/common_constants.dart';
import 'package:first_flutter_project/database/database_service.dart';
import 'package:first_flutter_project/injection.dart';
import 'package:first_flutter_project/models/admin.dart';
import 'package:first_flutter_project/pages/admin_details_page.dart';
import 'package:first_flutter_project/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();

  openDatabase(
    join(await getDatabasesPath(), 'split_bill_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE admin(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, address TEXT, creditCardNumber INTEGER)',
      );
    },
    version: 1,
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Admin?> getAdmin() async {
    var admins = (await getIt<DatabaseService>().getAdmin());
    if (admins.isEmpty) return null;
    return (await getIt<DatabaseService>().getAdmin())[0];
  }

  Future<Widget> navigateToFirstAppPage() async {
    if (await getAdmin() == null) {
      return const AdminDetailsPage(
        title: CommonConstants.createAdminTitle,
        buttonTitle: "CREATE",
      );
    } else {
      return const MyHomePage(
        title: CommonConstants.homePageTitle,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    return FutureBuilder<Widget>(
      future: navigateToFirstAppPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: ColorsLibrary.appGray),
              useMaterial3: true,
              fontFamily: GoogleFonts.titilliumWeb().fontFamily,
            ),
            home: snapshot.data,
          );
        }
      },
    );
  }
}
