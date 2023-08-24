import 'package:enable_bluetooh_profile_task/provider/image_provider.dart';
import 'package:enable_bluetooh_profile_task/provider/profile_provider.dart';
import 'package:enable_bluetooh_profile_task/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RandomImagePovider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          //currentFocus node check primary focus if doest not then call un focus
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Flutter Task',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomScreen(),
        ),
      ),
    );
  }
}
