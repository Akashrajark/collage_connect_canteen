import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustomButton extends StatefulWidget {
  final String? label;
  final IconData? iconData;
  final Color color, backGroundColor;
  final Function()? onPressed;
  final bool inverse, isLoading;

  const CustomButton({
    super.key,
    this.label,
    this.iconData,
    this.color = Colors.black,
    this.inverse = false,
    this.isLoading = false,
    required this.onPressed,
    this.backGroundColor = primaryColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            offset: !_hovering
                ? Offset.zero
                : const Offset(
                    2,
                    2,
                  ),
            blurRadius: !_hovering ? 0 : 2,
          ),
        ],
        color: widget.inverse ? widget.backGroundColor : secondaryColor,
        border: widget.inverse
            ? null
            : Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 1,
              ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: widget.onPressed,
        autofocus: widget.inverse,
        onHover: (value) {
          _hovering = value;
          setState(() {});
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: widget.label != null ? 15 : 10,
            right: widget.iconData != null ? 10 : 15,
            top: widget.iconData != null ? 7 : 7,
            bottom: widget.iconData != null ? 7 : 7,
          ),
          child: Row(
            mainAxisAlignment: widget.label != null && widget.iconData != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.center,
            children: [
              if (widget.label != null && !widget.isLoading)
                Text(
                  widget.label!,
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: widget.inverse ? secondaryColor : widget.color,
                      ),
                ),
              SizedBox(
                  width:
                      widget.label != null && widget.iconData != null ? 5 : 0),
              if (widget.iconData != null && !widget.isLoading)
                Icon(
                  widget.iconData,
                  color: widget.inverse ? Colors.white : widget.color,
                  size: 20,
                ),
              if (widget.isLoading)
                CupertinoActivityIndicator(
                  radius: 10,
                  color: widget.inverse ? Colors.white : widget.color,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
