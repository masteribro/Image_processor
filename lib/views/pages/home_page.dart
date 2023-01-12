import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/views/widgets/button.dart';
import 'package:image_editor/views/widgets/loading_indicator.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../controllers/home_controller.dart';
import '../widgets/color_filter.dart';
import '../widgets/colors.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
    Image? image,
  }) : super(key: key);

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {
  _HomePageState() : super(HomeController()) {
    con = controller as HomeController;
  }

  late HomeController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image processor'),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(bottom: 5.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: FutureBuilder<File>(
                    future: con.loadedFile(),
                    builder:
                        (BuildContext context, AsyncSnapshot<File> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.data != null) {
                        return FutureBuilder(
                            key: const Key("Preview Image"),
                            future: Future.delayed(const Duration(seconds: 3)),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return con.model.image != null
                                    ? ColorFiltered(
                                        colorFilter: con.model.changeColour
                                            ? ColorFilters.sepia
                                            : ColorFilters.none,
                                        child: Image.file(
                                          con.model.image!,
                                          width: 250,
                                          height: 250,
                                          key: const Key('my_image'),
                                        ))
                                    : const SizedBox();
                              } else {
                                return const Loader();
                              }
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Loader();
                      } else {
                        return const Center(child: Text("No Image Selected"));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                height: 80.h,
                width: 80.w,
                child: Column(
                  children: [
                    ImageButton(
                        key: const Key('select_Image'),
                        text: 'Select Image',
                        onPressed: () async {
                          String? imageResult = await con.pickImage();
                          print(
                              "Image Result in HomePage Fn Call(): $imageResult");
                          if (con.model.image != null) {
                            setState(() {
                              con.model.loading = false;
                            });
                          }
                          // setState(() { con.loading = true;}
                          // );
                        }),
                    SizedBox(
                      height: 1.h,
                    ),
                    ImageButton(
                        key: const Key('add_filter'),
                        text: 'Add filter',
                        onPressed: () {
                          setState(() {
                            con.model.changeColour = true;
                          });
                        }),
                    SizedBox(
                      height: 1.h,
                    ),
                    ImageButton(
                        key: const Key('remove_filter'),
                        text: 'Remove filter',
                        onPressed: () {
                          setState(() {
                            con.model.changeColour = false;
                          });
                        }),
                    SizedBox(
                      height: 1.h,
                    ),
                    ImageButton(
                        key: const Key('delete_image'),
                        text: 'Delete Image',
                        onPressed: () {
                          con.deleteImage();
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
