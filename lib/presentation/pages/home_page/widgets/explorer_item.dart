import 'package:flutter/material.dart';

class ExplorerItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const ExplorerItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Theme.of(context).splashColor : Colors.transparent,
      child: InkWell(
        onTapUp:  (details) => onTap(),
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
