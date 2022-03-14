import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gp/modules/user/result_of_detection/photo_details.dart';
class cameraScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: Icon(
          Icons.cancel,
          size: 30,
        ),
        title: Text(
          'Photo',
          style: TextStyle(
              fontSize: 30
          ),),
      ),
      body:Container(
        color: Colors.white,
        child: Column(
          children: [
            Image(
              image: NetworkImage('https://th.bing.com/th/id/R.181db64682d8636f392b7f5c079c590c?rik=irpWstcQOg2OWQ&pid=ImgRaw&r=0'),
              width: double.infinity,

            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  IconButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhotoDetails()
                          )
                      );
                    },
                    icon: Icon(Icons.camera,),
                    iconSize: 40,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
