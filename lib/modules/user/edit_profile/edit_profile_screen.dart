
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var weightController = TextEditingController();
  var goalWeightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){},
      builder: (context,state){

        var model = HomeCubit.get(context).userModel;

        nameController.text = model!.name!;
        ageController.text ='${model.age}' ;
        weightController.text ='${ model.weight}';
        goalWeightController.text = '${model.goalWeight}';

        var profileImage = HomeCubit.get(context).profileImage;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit profile',
            ),
            titleSpacing: 0,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Image(
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                          image: NetworkImage('https://img.freepik.com/free-photo/vegetables-set-left-black-slate_1220-685.jpg?w=1380'),
                        ),
                      ),
                      CircleAvatar(
                        radius: 52,
                        backgroundColor: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundImage: profileImage == null ? NetworkImage('${model.profileImage}') : FileImage(profileImage) as ImageProvider,
                              radius: 50,
                            ),
                            CircleAvatar(
                              backgroundColor: defaultColor,
                              radius:15,
                              child: IconButton(
                                  onPressed: (){
                                    HomeCubit.get(context).getProfileImage();
                                  },
                                  icon: Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                padding:EdgeInsets.zero,

                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      defaultTextFormField(type: TextInputType.text,
                          label: 'Name',
                          border: OutlineInputBorder(),
                          prefix: Icons.person,
                          controller: nameController),
                      SizedBox(height: 10,),
                      defaultTextFormField(
                          type: TextInputType.number,
                          label: 'Age',
                          border: OutlineInputBorder(),
                          prefix: Icons.info_outline,
                          controller: ageController),
                      SizedBox(height: 10,),
                      defaultTextFormField(type: TextInputType.number,label: 'weight',border: OutlineInputBorder(),prefix: Icons.accessibility_new_sharp,controller: weightController),
                      SizedBox(height: 10,),
                      defaultTextFormField(type: TextInputType.number,label: 'Goal Weight',border: OutlineInputBorder(),prefix: Icons.accessibility_new_sharp,controller: goalWeightController),
                      SizedBox(height: 10,),
                      defaultButton(context, onPreesed: (){
                        if(profileImage == null)
                        {
                          HomeCubit.get(context).updateUser(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            goalWeight: double.parse(goalWeightController.text),
                            weight: double.parse(weightController.text),
                          );
                        }else
                        {
                          HomeCubit.get(context).uploadProfileImage(
                            name: nameController.text,
                            age: int.parse(ageController.text),
                            goalWeight: double.parse(goalWeightController.text),
                            weight: double.parse(weightController.text),
                          );
                        }
                      },
                          text: 'Update'
                      ),
                      if(state is UploadProfileImageLoadingState)
                        LinearProgressIndicator(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
