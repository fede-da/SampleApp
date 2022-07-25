import 'package:flutter/material.dart';

class MySpacer extends StatelessWidget {
  MySpacer({Key? key, required this.height}) : super(key: key);
  double height;

  @override
  Widget build(BuildContext context) => SizedBox(height: height);
}
