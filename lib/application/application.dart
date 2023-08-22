import 'package:flutter/material.dart';
import 'package:my_notes/di.dart';
import 'package:my_notes/presentation/theme/color_schemes.dart';

import '../presentation/pages/home_page/home_page.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DiContainer(
      child: MaterialApp(
        theme: ThemeData.from(
          colorScheme: lightColorScheme,
          useMaterial3: true,
        ),
        darkTheme: ThemeData.from(
          colorScheme: darkColorScheme,
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
