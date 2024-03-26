import 'package:cheq/generated/assets.dart';
import 'package:flutter/material.dart';

import '../common/textStyle.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Assets.imagesPermissionLogo,
            height: MediaQuery.of(context).size.height / 4,
            width: MediaQuery.of(context).size.width / 4,
          ),
          Text(
            "Require Permission",
            style: CustomTextStyle.of(context)
                .titleBoldStyle(color: const Color(0xff383838))
                .copyWith(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "To show your black and white photos we just need your folder permission. We promise, we don’t take your photos.",
            style: CustomTextStyle.of(context)
                .subtitleRegularStyle(color: const Color(0xff383838))
                .copyWith(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width : MediaQuery.of(context).size.width * 0.7,
            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.black,
                backgroundColor: const Color(0xff66FFB6), // foreground
              ),
              onPressed: () { },
              child: const Text('Grant Access'),
            ),
          )
        ],
      ),
    );
  }
}
