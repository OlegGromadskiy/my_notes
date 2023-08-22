import 'package:flutter/material.dart';
import 'package:my_notes/domain/models/card_component/card_component.dart';

class ComponentSelectorDialog extends StatelessWidget {
  const ComponentSelectorDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      child: Card(
        elevation: 16.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.title_rounded),
              title: Text('Heading'),
              onTap: () {
                Navigator.of(context).pop<CardComponent>(
                  HeaderComponent(
                    content: '',
                    fontSize: 24.0,
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.check_box_rounded),
              title: Text('Checkboxes'),
              onTap: () {
                Navigator.of(context).pop<CardComponent>(CheckboxesComponent([]));
              },
            ),
            ListTile(
              leading: Icon(Icons.format_list_bulleted_rounded),
              title: Text('Bullet points'),
              onTap: () {
                Navigator.of(context).pop<CardComponent>(BulletPointsComponent([]));
              },
            ),
          ],
        ),
      ),
    );
  }
}
