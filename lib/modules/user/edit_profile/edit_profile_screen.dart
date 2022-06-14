import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/home-layout/cubit/cubit.dart';
import 'package:gp/layout/home-layout/cubit/states.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/localization/app_localization%20.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';
import 'package:simple_shadow/simple_shadow.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var nameController = TextEditingController();

  var ageController = TextEditingController();

  var weightController = TextEditingController();

  var goalWeightController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel;
        nameController.text = model!.name!;
        ageController.text = '${model.age}';
        weightController.text = '${model.weight}';
        goalWeightController.text = '${model.goalWeight}';

        var profileImage = HomeCubit.get(context).profileImage;

        return Scaffold(
          appBar: buildAppBar(
            title: AppLocalizations.of(context).translate("Edit profile"),
            //'Edit profile',
            titleSpacing: 0,
            icon: IconBroken.Arrow___Left_2,
            onPressed: () {
              Navigator.pop(context);
              HomeCubit.get(context).removeProfileImage();
            },
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            SimpleShadow(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 2),
                                child: CircleAvatar(
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${model.profileImage}')
                                      : FileImage(profileImage) as ImageProvider,
                                  radius: 50,
                                ),
                              ),
                              opacity: 0.5,
                              color: AppCubit.get(context).shadowColor,
                              offset: Offset(1, 1),
                              sigma: 5,
                            ),
                            CircleAvatar(
                              backgroundColor: defaultColor,
                              radius: 15,
                              child: IconButton(
                                onPressed: () {
                                  HomeCubit.get(context).getProfileImage();
                                },
                                icon: Icon(
                                  Icons.camera,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.zero,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        defaultTextFormField(
                            type: TextInputType.text,
                            hintText: AppLocalizations.of(context)
                                .translate("product_name"),
                            //'Name',
                            //border: OutlineInputBorder(),
                            prefix: Icons.person,
                            controller: nameController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context).translate(
                                    "name must not be empty"); //'name must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                            type: TextInputType.number,
                            hintText: AppLocalizations.of(context).translate("age"),//'Age',
                            //border: OutlineInputBorder(),
                            prefix: Icons.info_outline,
                            controller: ageController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context).translate(
                                    "validate_age"); //'Age must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                            type: TextInputType.number,
                            hintText: AppLocalizations.of(context)
                                .translate("weight"),
                            border: OutlineInputBorder(),
                            prefix: Icons.accessibility_new_sharp,
                            controller: weightController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context).translate(
                                    "validate_weight"); //'Weight must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultTextFormField(
                            type: TextInputType.number,
                            hintText: AppLocalizations.of(context)
                                .translate("goal_weight"),
                            //'Goal Weight',
                            border: OutlineInputBorder(),
                            prefix: Icons.accessibility_new_sharp,
                            controller: goalWeightController,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context).translate(
                                    "validate_goal_weight"); //'Goal Weight must not be empty';
                              }
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        defaultButton(
                          context,
                          onPreesed: () {
                            if (profileImage == null) {
                              HomeCubit.get(context).updateUser(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                goalWeight: double.parse(goalWeightController.text),
                                weight: double.parse(weightController.text),
                              );
                              showToast(text: AppLocalizations.of(context).translate("update_successful"), state: ToastStates.SUCCESS);
                            } else {
                              HomeCubit.get(context).uploadProfileImage(
                                name: nameController.text,
                                age: int.parse(ageController.text),
                                goalWeight: double.parse(goalWeightController.text),
                                weight: double.parse(weightController.text),
                              );
                              showToast(text: AppLocalizations.of(context).translate("update_successful"), state: ToastStates.SUCCESS);
                            }
                          },
                          text: AppLocalizations.of(context)
                              .translate("Update"), //'Update'
                        ),
                        if (state is UploadProfileImageLoadingState)
                          LinearProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
