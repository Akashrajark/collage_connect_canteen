import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const TextLink({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: primaryColor,
            ),
      ),
    );
  }
}
