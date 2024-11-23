import 'package:flutter/material.dart';


class CustomFlatButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color btnColor;

  const CustomFlatButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.btnColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'MontserratMedium',
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
