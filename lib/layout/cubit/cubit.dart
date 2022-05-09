
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:covid/layout/cubit/states.dart';
import 'package:covid/models/register_login_model.dart';
import 'package:covid/modules/account/account_screen.dart';
import 'package:covid/modules/camera/camera_screen.dart';
import 'package:covid/modules/hand_distancing/hand_distancing_screen.dart';
import 'package:covid/modules/heart_beat/heart_beat_screen.dart';
import 'package:covid/modules/home/home_screen.dart';
import 'package:covid/shared/component/constants.dart';
import 'package:covid/shared/network/end_points.dart';
import 'package:covid/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  var selectedIndex = 0;
  List<TabItem> bottomItems =
  [
    TabItem( icon: Icon(Icons.home,color: Colors.blue.shade200),),
    TabItem( icon: Icon(Icons.ondemand_video,color: Colors.blue.shade200),),
    TabItem( icon: Icon(Icons.camera_alt,color:Colors.blue.shade200),),
    TabItem( icon: Icon(Icons.favorite_border_outlined,color: Colors.blue.shade200)),
    TabItem( icon: Icon(Icons.person,color: Colors.blue.shade200)),
  ];

  List<Widget> bottomScreens =
  [
    HomeScreen(),
    HandDistancing(),
    CameraScreen(),
    HeartBeat(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    selectedIndex = index;
    emit(AppChangeBottomNavState());
  }


  // static const _url = '';

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url).then((value) {
        emit(AppSuccessLaunchCalling());
      }).catchError((error){
        emit(AppErrorLaunchCalling(error.toString()));
      });
    } else {
      throw 'Could not launch $url';
    }
  }
  void launchURL( String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
    emit(AppLaunchLinks());
  }

AppLoginModel userModel;

void getUserData() {
  emit(AppLoadingUserDataState());

  DioHelper.getData(
    url: PROFILE,
    token: token,
  ).then((value) {
    userModel = AppLoginModel.fromJson(value.data);
    printFullText(userModel.data.name);

    emit(AppSuccessUserDataState(userModel));
  }).catchError((error) {
    print(error.toString());
    emit(AppErrorUserDataState());
  });
}
  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,


  }) {
    emit(AppLoadingUpdateUserState());

    DioHelper.putData(
      url:  UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,

      },
    ).then((value) {
      userModel = AppLoginModel.fromJson(value.data);
      printFullText(userModel.data.name);

      emit(AppSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUpdateUserState());
    });
  }
}






























