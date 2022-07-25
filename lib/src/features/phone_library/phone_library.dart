import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_app/src/common_widgets/image_show.dart';

class PhoneLibrary extends StatefulWidget {
  PhoneLibrary({Key? key}) : super(key: key);
  XFile? _imagePicked;

  XFile getImage() {
    if (_imagePicked != null) {
      return _imagePicked!;
    } else {
      throw Exception("No image provided");
    }
  }

  @override
  State<PhoneLibrary> createState() => _PhoneLibraryState();
}

class _PhoneLibraryState extends State<PhoneLibrary> {
  final ImagePicker _picker = ImagePicker();

  XFile getImage() => widget._imagePicked!;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          ImageShow(image: widget._imagePicked),
          ElevatedButton(
              onPressed: (() async {
                widget._imagePicked =
                    await _picker.pickImage(source: ImageSource.gallery);
                setState(() {});
              }),
              child: const Text("Choose image"))
        ],
      );
}
