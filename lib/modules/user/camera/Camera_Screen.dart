import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/modules/user/result_of_detection/photo_details.dart';
import 'package:gp/shared/componants/componants.dart';
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
          appBar:  buildAppBar(
            title: 'Photo',
            icon: IconBroken.Arrow___Left_2,

            onPressed: () {
              Navigator.pop(context);
            },
          ),
          body: _isLoading! ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ) :
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Image(
                  image: _image == null ?  NetworkImage('https://clippingpathgreat.com/wp-content/uploads/2021/04/upload-files-1536x1061.jpg') : FileImage(_image!) as ImageProvider ,
                  width: double.infinity,
                ),
                SizedBox(
                  height: 10,
                ),
                _output == null ? Text('') : defaultHeadLineText(context,text: '${_output![0]['label']}'),
                Stack(
                    children: stackChildren
                ),
                SizedBox(
                  height: 10,
                ),
                defaultButton(
                    context,
                    onPreesed: ()
                    {
                      print(_output![0]['label']);
                      HomeCubit.get(context).getSearchPredictedMeal(_output![0]['label']);
                      navigateTo(context, PhotoDetails(image: _image!,));

                    }, text: 'show Food Information')


                //((res) {return Text( "${res["index"]} - ${res["label"]}: ${res["confidence"].toStringAsFixed(3)}",);}).toList(): [],),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: ()
            {
              chooseImage();
            },
            child: const Icon(
                IconBroken.Camera
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
      numResults: 35,
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
      model: "assets/model/food_model.tflite",
      labels: "assets/model/labels.txt",

    );
  }


}
