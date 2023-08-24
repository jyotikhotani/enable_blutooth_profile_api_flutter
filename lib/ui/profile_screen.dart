import 'package:enable_bluetooh_profile_task/provider/profile_provider.dart';
import 'package:enable_bluetooh_profile_task/ui/common/text_widget.dart';
import 'package:enable_bluetooh_profile_task/ui/profile_item.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).profileData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.profileScreen),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<ProfileProvider>(builder: (context, provider, child) {
          if (provider.isloading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: provider.profileList.length,
                  itemBuilder: (context, index) {
                    return ProfileItem(provider.profileList[index]);
                  }),
            );
          }
        }),
      ),
    );
  }
}
