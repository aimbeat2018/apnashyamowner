// Custom Pin Code Field For Verify Email
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../colors/colors.dart';

class PinCodeField extends StatelessWidget {
  final TextEditingController? textController;
  final Function(String)? onCompleted;

  const PinCodeField({super.key, this.textController, this.onCompleted});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      onCompleted: onCompleted,
      autoFocus: true,
      enableActiveFill: true,
      enabled: true,
      autoDismissKeyboard: true,
      appContext: context,
      length: 4,
      obscureText: false,
      obscuringCharacter: '∂',
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        activeColor: AppColors.activeColor,
        inactiveColor: AppColors.activeColor,
        inactiveFillColor: Colors.transparent,
        selectedColor: Colors.black,
        selectedFillColor: Colors.transparent,
        shape: PinCodeFieldShape.circle,
        fieldHeight: 70,
        fieldWidth: 70,
        activeFillColor: AppColors.activeFillColor,
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      controller: textController,
      keyboardType: TextInputType.number,
      // onCompleted: (v) {
      //   debugPrint("Completed");
      // },
      beforeTextPaste: (text) {
        debugPrint("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return false;
      },
      onChanged: (String value) {},
    );
  }
}
