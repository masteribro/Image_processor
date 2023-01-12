import 'package:flutter/material.dart';
import 'package:image_editor/views/pages/home_page.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (BuildContext , Orientation , ScreenType ) {
        return
          MaterialApp(
          title: 'Image Editor',
            debugShowCheckedModeBanner: false,
          theme: ThemeData(

          ),
          home:  HomePage(),
        );
      },

    );
  }
}

