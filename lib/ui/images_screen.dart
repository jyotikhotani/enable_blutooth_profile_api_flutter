import 'package:enable_bluetooh_profile_task/provider/image_provider.dart';
import 'package:enable_bluetooh_profile_task/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({super.key});

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RandomImagePovider>(context, listen: false)
          .imageData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringConst.randomDogImages),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer<RandomImagePovider>(builder: (context, provider, child) {
              if (provider.isloading) {
                return CircularProgressIndicator();
              } else {
                return SizedBox(
                  height: 300,
                  width: 300,
                  child: CachedNetworkImage(
                    imageUrl: provider.imageUrl,
                    placeholder: (context, url) => Icon(Icons.error),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                );
              }
            }),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue,
                  ),
                ),
                onPressed: () {
                  Provider.of<RandomImagePovider>(context, listen: false)
                      .imageData(context);
                },
                child: const Text(
                  StringConst.changeImage,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }
}
