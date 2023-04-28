

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_otp_verfication/homepage.dart';
import 'package:firebase_otp_verfication/otp.dart';
import 'package:firebase_otp_verfication/phone.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone': (context)=> MyPhone(onTimerUpdate: (int ) {  },),
      'otp': (context)=> MyOtp(),
      'home': (context)=> HomePage()
    }
  ));
}

