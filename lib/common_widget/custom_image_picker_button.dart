import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CustomImagePickerButton extends StatefulWidget {
  final String? selectedImage;
  final Function(PlatformFile file) onPick;
  final bool showRequiredError;
  final double height, width, borderRadius;

  const CustomImagePickerButton({
    super.key,
    required this.onPick,
    this.height = 100,
    this.width = 100,
    this.selectedImage,
    this.showRequiredError = false,
    this.borderRadius = 50,
  });

  @override
  State<CustomImagePickerButton> createState() =>
      _CustomImagePickerButtonState();
}

class _CustomImagePickerButtonState extends State<CustomImagePickerButton> {
  PlatformFile? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          color: Colors.grey[200],
          child: InkWell(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'jpeg'],
              );

              if (result != null && result.files.isNotEmpty) {
                _selectedFile = result.files.first;

                setState(() {});
                widget.onPick(result.files.first);
              }
            },
            borderRadius: BorderRadius.circular(widget.borderRadius),
            child: widget.selectedImage != null && _selectedFile == null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    child: Image.network(
                      widget.selectedImage!,
                      height: widget.height,
                      width: widget.width,
                      fit: BoxFit.cover,
                    ),
                  )
                : _selectedFile != null
                    ? ClipRRect(
                        borderRadius:
                            BorderRadius.circular(widget.borderRadius),
                        child: Image.memory(
                          _selectedFile!.bytes!,
                          height: widget.height,
                          width: widget.width,
                          fit: BoxFit.cover,
                        ),
                      )
                    : SizedBox(
                        height: widget.height,
                        width: widget.width,
                        child: const Icon(
                          Icons.add_photo_alternate_rounded,
                          color: Colors.grey,
                        ),
                      ),
          ),
        ),
        if (widget.showRequiredError)
          Padding(
            padding: const EdgeInsets.only(left: 5, top: 2),
            child: Text(
              'This photo is required',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.red[800],
                  ),
            ),
          ),
      ],
    );
  }
}
