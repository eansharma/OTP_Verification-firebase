import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_otp_verfication/otp.dart';
import 'package:flutter/material.dart';


class MyPhone extends StatefulWidget {
  const MyPhone({Key? key, required this.onTimerUpdate}) : super(key: key);

  static  String  verify ="";

  final Function(int) onTimerUpdate; // callback to pass timer value



  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var  phone = "";
  int start = 30;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countrycode.text ='+91';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/admin1.png'),
              ),
              Text('Phone Verfication',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10,),
              Text('We need to rgister your phone before getting start',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10)
                ),
                child:    Row(
                  children: [
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 49,
                      child: TextField(
                        controller: countrycode,
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Text('|', style: TextStyle(fontSize: 33, color: Colors.grey),),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child:  TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value){
                            phone = value;
                          },
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Phone"),
                        )
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child:ElevatedButton(onPressed: () async{
                  startTimer();
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countrycode.text + phone}',
                    verificationCompleted: (PhoneAuthCredential credential) {

                    },
                    verificationFailed: (FirebaseAuthException e) {

                    },
                    codeSent: (String verificationId, int? resendToken) {
                      MyPhone.verify = verificationId;
                      Navigator.pushNamed(context, "otp");
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                    },
                  // Navigator.pushNamed(context, "otp"
                  );
                }, child: Text("Send OTP"),
                  style: ElevatedButton.styleFrom(primary: Colors.green, shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )),) ,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startTimer(){
    const onsec= Duration(seconds: 1);
    Timer timer = Timer.periodic(onsec, (timer) {
      if(start== 0)
      {
        setState(() {
          timer.cancel();
        });

      }else{
        setState(() {
          start --;

        });

      }

    });
  }
}
