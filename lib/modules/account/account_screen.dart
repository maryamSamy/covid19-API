
import 'package:covid/shared/colors/colors.dart';
import 'package:covid/shared/component/component.dart';
import 'package:flutter/material.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:covid/layout/cubit/cubit.dart';
import 'package:covid/layout/cubit/states.dart';
import 'package:covid/shared/component/constants.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          condition: AppCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is AppLoadingUpdateUserState)
                    LinearProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultAppBar(
                    text: 'اعدادات الحساب ',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'يجب ادخال الاسم';
                      }

                      return null;
                    },
                    label: 'الاسم',
                    prefix: Icons.person,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'يجب ادخال البريد الالكتروني';
                      }

                      return null;
                    },
                    label: 'البريد الالكتروني',
                    prefix: Icons.email,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'يجب ادخال الرقم';
                      }

                      return null;
                    },
                    label:'رقم الهاتف',
                    prefix: Icons.phone,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    width: 200,
                    background: bluelightColor,
                    function: ()
                    {
                      if(formKey.currentState.validate())
                      {
                       AppCubit.get(context).updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      }
                    },
                    text: 'تحديث المعلومات',
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    function: () {
                      signOut(context);
                    },
                    text: 'تسجيل الخروج',
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

// import 'package:covid/shared/colors/colors.dart';
// import 'package:covid/shared/component/component.dart';
// import 'package:flutter/material.dart';
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:covid/layout/cubit/cubit.dart';
// import 'package:covid/layout/cubit/states.dart';
// import 'package:covid/shared/component/constants.dart';
//
// class SettingsScreen extends StatelessWidget {
//   var formKey = GlobalKey<FormState>();
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var phoneController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var model = AppCubit.get(context).userModel;
//
//         nameController.text = model.data.name;
//         emailController.text = model.data.email;
//         phoneController.text = model.data.phone;
//
//         return ConditionalBuilder(
//           condition: AppCubit.get(context).userModel != null,
//           builder: (context) => Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: formKey,
//               child: Column(
//                 children:
//                 [
//                   if(state is AppLoadingUpdateUserState)
//                     LinearProgressIndicator(),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   defaultAppBar(
//                     text: 'اعدادات الحساب ',
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   defaultFormField(
//                     controller: nameController,
//                     type: TextInputType.name,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'يجب ادخال الاسم';
//                       }
//
//                       return null;
//                     },
//                     label: 'الاسم',
//                     prefix: Icons.person,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   defaultFormField(
//                     controller: emailController,
//                     type: TextInputType.emailAddress,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'يجب ادخال البريد الالكتروني';
//                       }
//
//                       return null;
//                     },
//                     label: 'البريد الالكتروني',
//                     prefix: Icons.email,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   defaultFormField(
//                     controller: phoneController,
//                     type: TextInputType.phone,
//                     validate: (String value) {
//                       if (value.isEmpty) {
//                         return 'يجب ادخال الرقم';
//                       }
//
//                       return null;
//                     },
//                     label:'رقم الهاتف',
//                     prefix: Icons.phone,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   defaultButton(
//                     width: 200,
//                     background: bluelightColor,
//                     function: ()
//                     {
//                       if(formKey.currentState.validate())
//                       {
//                         AppCubit.get(context).updateUserData(
//                           name: nameController.text,
//                           phone: phoneController.text,
//                           email: emailController.text,
//                         );
//                       }
//                     },
//                     text: 'تحديث المعلومات',
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   defaultButton(
//                     function: () {
//                       signOut(context);
//                     },
//                     text: 'تسجيل الخروج',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           fallback: (context) => Center(child: CircularProgressIndicator()),
//         );
//       },
//     );
//   }
// }
