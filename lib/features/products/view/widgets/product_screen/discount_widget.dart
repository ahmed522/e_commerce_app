import 'package:flutter/material.dart';

class DiscountWidget extends StatelessWidget {
  const DiscountWidget({
    Key? key,
    required this.discount,
  }) : super(key: key);
  final double discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(
          Radius.circular(8.0),
        ),
        border: Border.all(
          color: Colors.red,
          width: 1.5,
        ),
        color: Colors.transparent,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0),
        child: Row(
          children: [
            Text(
              '$discount%',
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
            const Icon(
              Icons.arrow_downward_rounded,
              color: Colors.red,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
