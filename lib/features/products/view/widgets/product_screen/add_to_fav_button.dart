import 'package:flutter/material.dart';

class AddToFavButton extends StatelessWidget {
  const AddToFavButton({
    Key? key,
    required this.isFav,
    required this.onPressed,
  }) : super(key: key);
  final bool isFav;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () => onPressed(),
      elevation: 0.5,
      color: Colors.white,
      padding: const EdgeInsets.all(1.0),
      minWidth: 50,
      splashColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        Icons.favorite_rounded,
        color: isFav ? Colors.red : Colors.grey.shade700,
        size: 25,
      ),
    );
  }
}
