import 'package:flutter/material.dart';
import 'package:my_notes/domain/models/card_component/card_component.dart';

import 'header_component_widget.dart';

class CardComponentWidget extends StatelessWidget {
  final CardComponent component;

  const CardComponentWidget({
    Key? key,
    required this.component,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final temp = component;

    return switch (temp) {
      HeaderComponent() => HeaderComponentWidget(component: temp),
      _ => const SizedBox(),
    };
  }
}
