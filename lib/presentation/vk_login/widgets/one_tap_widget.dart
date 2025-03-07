import 'package:flutter/material.dart';
import 'package:vkid_flutter_sdk/library_vkid.dart';

class OneTapWidget extends StatelessWidget {
  final void Function(String? refreshToken) onAuth;

  const OneTapWidget({super.key, required this.onAuth});

  @override
  Widget build(BuildContext context) {
    return OneTap(
      key: GlobalKey(),
      onAuth: (onAuth, authData) {
        print('Auth data: ${authData.token}');
      },
      style: OneTapStyle(
        cornersStyle: OneTapCornersRounded(),
      ),
      signInToAnotherAccountButtonEnabled: true,
    );
  }
}
