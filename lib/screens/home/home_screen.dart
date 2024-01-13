import 'dart:convert';
import 'dart:core';
import 'package:image/image.dart' as img;
import 'package:appstock/screens/home/side_menu_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();
  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return SideMenu(
      key: sideMenuKey,
      background: Colors.black,
      menu: SideMenuList(
        menuKey: sideMenuKey,
      ),
      maxMenuWidth: 360,
      type: SideMenuType.slideNRotate,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          leading: IconButton(
            onPressed: () {
              if (sideMenuKey.currentState!.isOpened) {
                sideMenuKey.currentState!.closeSideMenu();
              } else {
                sideMenuKey.currentState!.openSideMenu();
              }
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          title: const Text(
            'Welcome, you are In !',
            style: TextStyle(
              color: Colors.white, // Change this to the color you want
              fontSize:
                  20, // Optional: You can also set other styles such as fontSize
              fontWeight:
                  FontWeight.bold, // Optional: You can set the font weight
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              _selectedImage != null
                  ? Align(
                      alignment: Alignment.topCenter, // Align to the top center
                      child: Image.file(_selectedImage!),
                    )
                  : const Align(
                      alignment: Alignment.topCenter, // Align to the top center
                      child: Text("Please select an image"),
                    ),
              SizedBox(height: 100.0, width: 30.0),
              Container(
                width: 150.0,
                child: FloatingActionButton(
                  onPressed: () {
                    uploadImageAndDetect();
                  },
                  heroTag: "Save",
                  backgroundColor: Color.fromARGB(255, 11, 165, 236),
                  child: const Text(
                    "Check Free space",
                    style: TextStyle(
                      color: Colors.white, // Change this to the color you want

                      // Optional: You can set the font weight
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            _pickImageFromGallery();
                          },
                          backgroundColor: Color.fromARGB(255, 11, 165, 236),
                          heroTag: "gallery",
                          child: const Icon(
                            Icons.insert_drive_file,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: FloatingActionButton(
                          onPressed: () {
                            _pickImageFromCamera();
                          },
                          backgroundColor: Color.fromARGB(255, 11, 165, 236),
                          heroTag: "camera",
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> uploadImageAndDetect() async {
    if (_selectedImage != null) {
      try {
        // Load Image and Convert to Bytes
        List<int> imageBytes = await _selectedImage!.readAsBytes();
        // Initialize Inference Server Request
        var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://detect.roboflow.com/package-detection-kt9ut/2?api_key=FsWNbwUFJseSnhN13fCm&name=image'),
        );

        // Add the image file as a MultipartFile to the request
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            imageBytes,
            filename: 'image.jpg', // Provide a filename for the image
          ),
        );

        // Send the request
        http.StreamedResponse response = await request.send();

        // Parse Response
        if (response.statusCode == 200) {
          Map<String, dynamic> responseData =
              json.decode(await response.stream.bytesToString());

          List<dynamic> predictions = responseData['predictions'];

          if (predictions.isNotEmpty) {
            double imageWidthInPixels = predictions[0]['width'].toDouble();
            double imageHeightInPixels = predictions[0]['height'].toDouble();
            // Assuming you have the DPI information for the image
            double dpi = 72.0; // Replace with the actual DPI value

// Convert pixels to centimeters
            double imageWidthInCm =
                ((imageWidthInPixels / dpi) * 2.54); // 2.54 cm in an inch
            double imageHeightInCm = (imageHeightInPixels / dpi) * 2.54;

            double newImageWidth =
                num.parse(imageWidthInCm.toStringAsFixed(2)) as double;
            double newImageHeight =
                num.parse(imageHeightInCm.toStringAsFixed(2)) as double;

// Now, you can use imageWidthInCm and imageHeightInCm for comparison
            print('Image Width in cm: $newImageWidth');
            print('Image Height in cm: $newImageHeight');
          }
        } else {
          print('Error: ${response.statusCode}');
          print(await response.stream.bytesToString());
        }
      } catch (e) {
        print('Error during image processing: $e');
        // Handle the error, e.g., show an error message to the user
      }
    }
    ;
  }
}
