import 'package:cached_network_image/cached_network_image.dart';
import 'package:enable_bluetooh_profile_task/model/profile_model.dart';
import 'package:enable_bluetooh_profile_task/utils/colors.dart';
import 'package:enable_bluetooh_profile_task/utils/common_methods.dart';
import 'package:flutter/material.dart';

import 'common/text_widget.dart';

class ProfileItem extends StatelessWidget {
  final Results resultItem;
  const ProfileItem(this.resultItem, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: textgreyColor)),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            child: CachedNetworkImage(
              imageUrl: resultItem.picture!.medium!,
              placeholder: (context, url) => Icon(Icons.error),
              errorWidget: (context, url, error) => Icon(Icons.error),
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${resultItem.name!.first!} " "${resultItem.name!.last}",
            style: TextStyle(
                color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${resultItem.email}",
            style: TextStyle(
                color: blueColor, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "DOB : ${CommonMethods.convertDDMMYY(resultItem.dob!.date!)} ",
            style: TextStyle(
                color: purple, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "City : ${resultItem.location!.city} ",
            style: TextStyle(
                color: green, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Registerd: ${CommonMethods.differenceinDays(resultItem.registered!.date!)} days ago ",
            style: TextStyle(
                color: blueDark, fontWeight: FontWeight.w500, fontSize: 12),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
