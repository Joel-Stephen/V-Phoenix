import 'dart:io';
import 'package:app_template/src/screens/home_page.dart';
import 'package:app_template/src/utils/utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class NewsPage extends StatefulWidget {
  final String image;
  final String title;
  final String description;
  final String content;
  NewsPage({this.image, this.title, this.description, this.content});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final picker = ImagePicker();
  File imagePicked;
  File imageCropped;
  bool onPress = false;
  final scaffoldState = GlobalKey<ScaffoldState>();

  Future<Null> _cropImage(PickedFile pickedFile) async {
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      setState(() {
        imageCropped = croppedFile;
      });
    }
  }

  Future getImageCamera() async {
    PermissionStatus _permissionStatus = await Permission.camera.request();
    if (_permissionStatus.isGranted) {
      final pickedFile = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 25,
      );
      if (pickedFile != null) _cropImage(pickedFile);
    } else
      showAlert(context, "App needs camera permission", openAppSettings);
  }

  Future getImageGallery() async {
    PermissionStatus _permissionStatus = await Permission.storage.request();
    if (_permissionStatus.isGranted) {
      final pickedFile =
          await picker.getImage(source: ImageSource.gallery, imageQuality: 25);
      if (pickedFile != null) _cropImage(pickedFile);
    } else
      showAlert(context, "App needs storage permission", openAppSettings);
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60))),
              height: screenHeight(context, dividedBy: 4),
              width: screenWidth(context, dividedBy: 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: screenWidth(context, dividedBy: 10)),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            onPress = false;
                          });
                        },
                        child: Icon(
                          Icons.close_rounded,
                          size: 30,
                          color: Colors.black,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                          onTap: () {
                            getImageCamera();
                            Navigator.pop(context);
                            setState(() {
                              onPress = false;
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera,
                                size: 50,
                                color: Colors.black,
                              ),
                              Text(
                                "Camera",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                      GestureDetector(
                          onTap: () {
                            getImageGallery();
                            Navigator.pop(context);
                            setState(() {
                              onPress = false;
                            });
                          },
                          child: Column(
                            children: [
                              Icon(
                                Icons.image,
                                size: 50,
                                color: Colors.black,
                              ),
                              Text(
                                "Gallery",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context, dividedBy: 1),
        width: screenWidth(context, dividedBy: 1),
        color: Colors.white,
        padding: EdgeInsets.symmetric(
            vertical: screenHeight(context, dividedBy: 100),
            horizontal: screenHeight(context, dividedBy: 100)),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight(context, dividedBy: 20),
                  ),
                  GestureDetector(
                      onTap: () {
                        pushAndReplacement(context, HomePage());
                      },
                      child: Container(
                          width: screenWidth(context, dividedBy: 10),
                          height: screenWidth(context, dividedBy: 10),
                          padding: EdgeInsets.only(left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.withOpacity(0.5)),
                          child: Center(
                              child: Icon(
                            Icons.arrow_back_ios,
                            size: screenWidth(context, dividedBy: 18),
                          )))),
                  Container(
                    width: screenWidth(context, dividedBy: 1),
                    padding: EdgeInsets.only(
                        left: screenWidth(context, dividedBy: 40)),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                          fontSize: screenWidth(context, dividedBy: 18),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 80),
                  ),
                  imageCropped == null
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.withOpacity(0.5),
                                width: 0.5),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: widget.image == null
                                ? "https://i1.wp.com/fremontgurdwara.org/wp-content/uploads/2020/06/no-image-icon-2.png"
                                : widget.image,
                            imageBuilder: (context, imageProvider) => Container(
                              width: screenWidth(context, dividedBy: 1),
                              height: screenHeight(context, dividedBy: 4),
                              decoration: BoxDecoration(
                                // color: Constants.kitGradients[2],
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.5),
                                    width: 0.5),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: screenWidth(context, dividedBy: 1),
                              height: screenHeight(context, dividedBy: 5),
                              child: Center(
                                heightFactor: 1,
                                widthFactor: 1,
                                child: SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(
                                        Colors.grey.withOpacity(0.3)),
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                            ),
                            //fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: screenWidth(context, dividedBy: 1),
                          height: screenHeight(context, dividedBy: 4),
                          child: Image.file(
                            imageCropped,
                            fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 120),
                  ),
                  widget.description == null
                      ? Container()
                      : Text(widget.description,
                          style: TextStyle(
                              fontSize: screenWidth(context, dividedBy: 30),
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.center),
                  SizedBox(
                    height: screenHeight(context, dividedBy: 120),
                  ),
                  widget.content == null
                      ? Container()
                      : Text(widget.content,
                          style: TextStyle(
                              fontSize: screenWidth(context, dividedBy: 20),
                              fontWeight: FontWeight.w500))
                ],
              ),
            ),
            onPress
                ? Container()
                : Positioned(
                    bottom: 100,
                    right: 5,
                    child: FloatingActionButton(
                      onPressed: () {
                        _showSheet(context);
                        setState(() {
                          onPress = true;
                        });
                      },
                      backgroundColor: Colors.red,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          size: 35,
                          color: Colors.white,
                        ),
                      ),
                    )),
          ],
        ),
      ),
    );
  }
}
