import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/result_of_detection/photo_details.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List? outputs;

  File? _image;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    loading = true;
    loadModel().then((value) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    stackChildren.add(Center(
      child: Column(
        children: outputs != null
            ? outputs!.map((res) {
                return Text(
                  "${res["label"]}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    background: Paint()..color = Colors.white,
                  ),
                );
              }).toList()
            : [],
      ),
    ));

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: buildAppBar(
            title: AppLocalizations.of(context).translate("photo"), //'Photo',
            icon: IconBroken.Arrow___Left_2,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          body: loading
              ? Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Image(
                        image: _image == null
                            ? const NetworkImage(
                                'https://clippingpathgreat.com/wp-content/uploads/2021/04/upload-files-1536x1061.jpg')
                            : FileImage(_image!) as ImageProvider,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      outputs != null
                          ? defaultBodyText(context,
                          text: outputs!.isNotEmpty ? "${outputs![0]["label"]}" : 'take another pic please'
                      )
                          : Container(),
                      //Stack(children: stackChildren),

                      //((res) {return Text( "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",);}).toList(): [],),
                    ],
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              /*defaultContainer(
              context,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          defaultBodyText(context, text: '1.Make Sure you take photo for one meal'),
                          SizedBox(
                            height: 5,
                          ),
                          defaultBodyText(context, text: '2.Focus for one meal to best dedication'),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: defaultColor,
                      child: IconButton(onPressed: ()
                      {
                        chooseImage();
                      }, icon: const Icon(
                        IconBroken.Camera,
                        color: Colors.white,
                      ),
                      ),
                    )

                  ],
                ),
              ),
            ),*/
              /*  scaffoldKey.currentState!.showBottomSheet((context) => defaultContainer(
                context,
                radius: 0,

                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children:
                    [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultBodyText(context, text: '1.Make Sure you take photo for one meal'),
                            SizedBox(
                              height: 5,
                            ),
                            defaultBodyText(context, text: '2.Focus for one meal to best dedication'),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: defaultColor,
                        child: IconButton(onPressed: ()
                        {
                          chooseImage();
                        }, icon: const Icon(
                          IconBroken.Camera,
                          color: Colors.white,
                        ),
                        ),
                      )

                    ],
                  ),
                ),
              ),);*/
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                      color: AppCubit.get(context).constantColor1,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultBodyText(context,
                                      text: AppLocalizations.of(context)
                                          .translate("condition1_to_upload")),
                                  //'1.Make Sure you take photo for one meal'),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  defaultBodyText(context,
                                      text: AppLocalizations.of(context)
                                          .translate("condition2_to_upload")),
                                  //'2.Focus for one meal to best dedication'),
                                ],
                              ),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      pickImage();
                                      Navigator.pop(context, Container());
                                    },
                                    icon: const Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: defaultColor,
                                  child: IconButton(
                                    onPressed: () {
                                      pickImageOfGallery();
                                      Navigator.pop(context, Container());
                                    },
                                    icon: const Icon(
                                      Iconsax.gallery,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                barrierDismissible: true,

              );
            },
            child: const Icon(
                IconBroken.Camera
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              color: defaultColor,
              child: InkWell(
                onTap: () {
                  if (_image != null && outputs != null) {
                    print(outputs![0]['label']);
                    HomeCubit.get(context)
                        .getSearchPredictedMeal(outputs![0]['label']); //
                    navigateTo(
                        context,
                        PhotoDetails(
                          image: _image!,
                        ));
                  } else {
                    showToast(
                        text: AppLocalizations.of(context).translate(
                            "note_to_upload"), //'please upload Image',
                        state: ToastStates.ERROR);
                  }
                },
                child: SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate("show_food"),
                      //'Show Food Info',
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  ImagePicker? picker = ImagePicker();

  Future? pickImage() async {
    final image = await picker!.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      loading = true;
      _image = File(image.path);
    });
    calssifyImage(_image!);
  }
  Future? pickImageOfGallery() async {
    final image = await picker!.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      loading = true;
      _image = File(image.path);
    });
    calssifyImage(_image!);
  }

  calssifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 27,
        threshold: .5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      loading = false;
      outputs = output;
    });
  }

  Future recognizeImageBinary(File image) async {
    var imageBytes = await image.readAsBytesSync();
    var bytes = imageBytes.buffer.asUint8List();
    img.Image? oriImage = img.decodeJpg(bytes);
    img.Image resizedImage = img.copyResize(oriImage!, height: 224, width: 224);
    /*var imageBytes = (await rootBundle.load(image.path)).buffer;
   img.Image? oriImage = img.decodeJpg(imageBytes.asUint8List());
   img.Image resizedImage = img.copyResize(oriImage!, height: 224, width: 224);*/
    var output = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 27,
      threshold: 0.05,
    );
    setState(() {
      loading = false;
      outputs = output;
    });
    print(outputs);
  }
  Uint8List imageToByteListFloat32(
      img.Image image, int inputSize, double mean, double std) {
    var convertedBytes = Float32List(1 * inputSize * inputSize * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (img.getRed(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getGreen(pixel) - mean) / std;
        buffer[pixelIndex++] = (img.getBlue(pixel) - mean) / std;
      }
    }
    return convertedBytes.buffer.asUint8List();
  }

  /*
  Uint8List imageToByteListUint8(img.Image image, int inputSize) {
    var convertedBytes = Uint8List(1 * inputSize * inputSize * 3);
    var buffer = Uint8List.view(convertedBytes.buffer);
    int pixelIndex = 0;
    for (var i = 0; i < inputSize; i++) {
      for (var j = 0; j < inputSize; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = img.getRed(pixel);
        buffer[pixelIndex++] = img.getGreen(pixel);
        buffer[pixelIndex++] = img.getBlue(pixel);
      }
    }
    return convertedBytes.buffer.asUint8List();
  }
  */



  Future loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/model_unquant.tflite",
        labels: "assets/model/labels.txt");
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}
