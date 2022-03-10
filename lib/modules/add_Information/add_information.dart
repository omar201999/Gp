import 'package:flutter/material.dart';
import 'package:gp/modules/register/register_screen.dart';
import 'package:gp/shared/componants/componants.dart';

class AddInformation extends StatelessWidget {
  var weightController = TextEditingController();
  var heightController = TextEditingController();
  var genderController = TextEditingController();
  var goalweightController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            children:
            [
              defualtTextFormField(
                controller: weightController,
                type: TextInputType.number,
                validate: (String? value)
                {
                  if(value!.isEmpty)
                  {
                    return 'please enter your name';
                  }
                },
                label: 'Weight',

              ),
              SizedBox(
                height: 20,
              ),
              defualtTextFormField(
                controller: heightController,
                type: TextInputType.number,
                validate: (String? value)
                {
                  if(value!.isEmpty)
                  {
                    return 'please enter your name';
                  }
                },
                label: 'Height',

              ),
              SizedBox(
                height: 20,
              ),
              defualtTextFormField(
                controller: genderController,
                type: TextInputType.text,
                validate: (String? value)
                {
                  if(value!.isEmpty)
                  {
                    return 'please enter your name';
                  }
                },
                label: 'Gender',

              ),
              SizedBox(
                height: 20,
              ),
              defualtTextFormField(
                controller: goalweightController,
                type: TextInputType.number,
                validate: (String? value)
                {
                  if(value!.isEmpty)
                  {
                    return 'please enter your name';
                  }
                },
                label: 'Goal weight',

              ),
              SizedBox(
                height: 20,
              ),

              DefaultButton(
                context,
                text: 'Go to Register Our App ',
                onPreesed: ()
                  {
                    if(formKey.currentState!.validate())
                    {
                      navigateTo(context, RegisterScreen(
                        weight: double.parse(weightController.text),
                        height: double.parse(heightController.text),
                        gender: genderController.text,
                        goalweight: double.parse(goalweightController.text),

                      )
                      );

                    }

                  },
              ),


            ],
          ),
        ),
      ),
    );
  }
}
