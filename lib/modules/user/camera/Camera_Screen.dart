import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/result_of_detection/photo_details.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:image/image.dart' as img;


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);


  @override
  State<CameraScreen> createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
{
  var scaffoldKey = GlobalKey<ScaffoldState>();

  bool? _isLoading;
  File? _image;
  List? _output;

@override
  void initState() {
    super.initState();
    _isLoading = true;
    loadModel().then((value){
      setState(() {
        _isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> stackChildren = [];
    stackChildren.add(Center(
      child: Column(
        children: _output != null
            ? _output!.map((res) {
          return Text(
            "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",
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

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state) {},
      builder: (context,state)
      {

        return Scaffold(
          key: scaffoldKey,
          appBar:  buildAppBar(
            title: AppLocalizations.of(context).translate("photo"),//'Photo',
            icon: IconBroken.Arrow___Left_2,

            onPressed: () {
              Navigator.pop(context);
            },
          ),
          body: _isLoading! ? Container(
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          ) :
          Column(
            children: [
              Image(
                image: _image == null ?  const NetworkImage('https://clippingpathgreat.com/wp-content/uploads/2021/04/upload-files-1536x1061.jpg') : FileImage(_image!) as ImageProvider ,
                width: double.infinity,
              ),
              SizedBox(
                height: 5,
              ),
              _output == null ? Text('') : Padding(
                padding: const EdgeInsets.all(10),
                child: defaultContainer(
                  context,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: defaultHeadLineText(
                            context,
                            text: '${_output![0]['label']}',
                            fontSize: 30
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                  children: stackChildren
              ),

              //((res) {return Text( "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",);}).toList(): [],),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
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
              var sheetController = showModalBottomSheet(
                  context: context,
                  builder: (context) => CameraImagePicker());
              sheetController.then((value) {});





            },
            child: const Icon(
                Icons.open_in_browser,
            ),

          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(

              color: defaultColor,
              child: InkWell(
                onTap: ()
                {
                  if(_image != null && _output != null)
                  {
                    print(_output![0]['label']);
                    HomeCubit.get(context).getSearchPredictedMeal(_output![0]['label']);//
                    navigateTo(context, PhotoDetails(image: _image!,));
                  }
                  else
                    {
                      showToast(
                          text: AppLocalizations.of(context).translate("note_to_upload"),//'please upload Image',
                          state: ToastStates.ERROR);
                    }

                },
                child:  SizedBox(
                  height: kToolbarHeight,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context).translate("show_food"),//'Show Food Info',
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
  Future? chooseImage() async {
    final image = await picker?.pickImage(
        source: ImageSource.camera
    );
    if (image == null ) return null;
    setState(() {
      _isLoading = true;
      _image = File(image.path);
    });
    print(File(image.path));
    runModelOnImage(File(image.path));
  }

 runModelOnImage(File image)
  async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
      numResults: 33,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.5
    );
    setState(() {
      _isLoading = false;
     _output = output;
    });
    print(_output);
  }

  Future recognizeImageBinary(File image) async {
    var imageBytes = (await rootBundle.load(image.path)).buffer;
    img.Image? oriImage = img.decodeJpg(imageBytes.asUint8List());
    img.Image resizedImage = img.copyResize(oriImage!, height: 224, width: 224);
    var output = await Tflite.runModelOnBinary(
      binary: imageToByteListFloat32(resizedImage, 224, 127.5, 127.5),
      numResults: 10,
      threshold: 0.05,
    );
    setState(() {
      _isLoading = false;
      _output = output;
    });
    print(_output);
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



  Future loadModel()
  async {
    await Tflite.loadModel(
      model: "assets/model/model.tflite",
      labels: "assets/model/labels.txt",

    );
  }


}


class  CameraImagePicker extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return defaultContainer(
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
    defaultBodyText(context, text: AppLocalizations.of(context).translate("condition1_to_upload")),//'1.Make Sure you take photo for one meal'),
    SizedBox(
    height: 5,
    ),
    defaultBodyText(context, text: AppLocalizations.of(context).translate("condition2_to_upload")),//'2.Focus for one meal to best dedication'),
    ],
    ),
    ),
    CircleAvatar(
    radius: 25,
    backgroundColor: defaultColor,
    child: IconButton(onPressed: ()
{

}, icon: const Icon(
IconBroken.Camera,
color: Colors.white,
),
),
)

],
),
),
);
  }
}


