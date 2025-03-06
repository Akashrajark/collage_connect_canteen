import 'package:flutter/material.dart';

class CustomActionbutton extends StatelessWidget {
  const CustomActionbutton({
    super.key,
    required this.ontap,
    required this.title,
    required this.icon,
    required this.color,
  });
  final Function()? ontap;
  final IconData icon;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: color,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
