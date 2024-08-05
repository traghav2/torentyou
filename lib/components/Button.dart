import 'package:flutter/material.dart';
import 'package:torentyou/consts.dart';

class ButtonCustom extends StatelessWidget {
  final VoidCallback callback;
  final String title;
  final LinearGradient gradient;

  const ButtonCustom({
    super.key,
    required this.callback,
    required this.title,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: callback, // Callback for the button
        child: Ink(
          width: 100,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: gradient,
          ),
          child:  Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
    );
  }
}
