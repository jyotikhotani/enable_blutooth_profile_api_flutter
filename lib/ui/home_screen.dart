import 'package:enable_bluetooh_profile_task/ui/images_screen.dart';
import 'package:enable_bluetooh_profile_task/ui/profile_screen.dart';
import 'package:enable_bluetooh_profile_task/utils/colors.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomScreen extends StatefulWidget {
  const HomScreen({super.key});

  @override
  State<HomScreen> createState() => _HomScreenState();
}

class _HomScreenState extends State<HomScreen> {
  static const platform = MethodChannel('bluetooth_control');
  bool isBluettohEnable = false;

  Future<void> enableBluetooth() async {
    try {
      await platform.invokeMethod('enableBluetooth');
      isBluettohEnable = true;
      setState(() {});
    } on PlatformException catch (e) {
      print('Error: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ImagesScreen()),
                  );
                },
                child: const Text(
                  StringConst.images,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isBluettohEnable ? green : Colors.blue,
                  ),
                ),
                onPressed: () {
                  enableBluetooth();
                },
                child: Text(
                  isBluettohEnable
                      ? StringConst.enabled
                      : StringConst.enableBluetooth,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
                child: const Text(
                  StringConst.profile,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
