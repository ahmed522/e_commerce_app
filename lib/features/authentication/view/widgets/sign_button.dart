import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class SignButton extends StatelessWidget {
  final void Function() onPressed;
  final bool loading;
  final String text;
  const SignButton({
    Key? key,
    required this.onPressed,
    required this.loading,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(right: 35.0),
        child: ElevatedButton(
          onPressed: loading ? null : () => onPressed(),
          child: loading
              ? const AppCircularProgressIndicator(width: 25, height: 25)
              : Text(text),
        ),
      ),
    );
  }
}
