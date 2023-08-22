import 'package:flutter/material.dart';
import 'package:my_notes/domain/models/card_component/card_component.dart';

class HeaderComponentWidget extends StatefulWidget {
  final HeaderComponent component;

  const HeaderComponentWidget({
    Key? key,
    required this.component,
  }) : super(key: key);

  @override
  State<HeaderComponentWidget> createState() => _HeaderComponentWidgetState();
}

class _HeaderComponentWidgetState extends State<HeaderComponentWidget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(),
      ),
    );
  }
}
//Text(
//component.content,
//style: TextStyle(
//fontWeight: FontWeight.bold,
//fontSize: component.fontSize,
//),
//)