import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String? title;
  final double width;
  final int? maxLines, minLines;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final IconData? prefixIconData, suffixIconData;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.width = 400,
    this.title,
    required this.controller,
    required this.validator,
    this.prefixIconData,
    this.suffixIconData,
    this.maxLines,
    this.minLines,
    this.contentPadding,
    required bool isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(width: width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Text(
              title!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (title != null) const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            validator: validator,
            minLines: minLines,
            maxLines: maxLines,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: contentPadding ??
                  ((prefixIconData != null || suffixIconData != null)
                      ? null
                      : const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        )),
              hintText: labelText,
              suffixIcon: suffixIconData != null
                  ? Icon(
                      suffixIconData,
                    )
                  : null,
              prefixIcon: prefixIconData != null
                  ? Padding(
                      padding:
                          EdgeInsets.only(bottom: minLines != null ? 45 : 0),
                      child: Icon(
                        prefixIconData,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
