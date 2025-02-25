import 'package:flutter/material.dart';

import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? description, primaryButton, secondaryButton;
  final Widget? content;
  final Function()? onPrimaryPressed, onSecondaryPressed;
  final double width;
  final List<Widget>? action;
  final bool isLoading;
  const CustomAlertDialog({
    super.key,
    required this.title,
    this.description,
    this.primaryButton,
    this.secondaryButton,
    this.content,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.width = 400,
    this.isLoading = false,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                )),
                  ),
                  if (action != null) ...action!,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.black45,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              if (isLoading)
                const LinearProgressIndicator(
                  minHeight: 1,
                )
              else
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Colors.black12,
                ),
              const SizedBox(height: 5),
              if (description != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          description!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              if (content != null) content!,
              const SizedBox(
                height: 10,
              ),
              if (primaryButton != null && secondaryButton != null)
                const Divider(
                  height: 20,
                  thickness: 1,
                  color: Colors.black12,
                ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: width,
                ),
                child: Row(
                  children: [
                    if (secondaryButton != null)
                      Expanded(
                        child: CustomButton(
                          label: secondaryButton,
                          onPressed: isLoading
                              ? null
                              : onSecondaryPressed ??
                                  () => Navigator.pop(context),
                          color: Colors.grey,
                        ),
                      ),
                    if (primaryButton != null && secondaryButton != null)
                      const SizedBox(width: 10),
                    if (primaryButton != null)
                      Expanded(
                        child: CustomButton(
                          label: primaryButton,
                          inverse: true,
                          onPressed: isLoading
                              ? null
                              : onPrimaryPressed ??
                                  () => Navigator.pop(context),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
