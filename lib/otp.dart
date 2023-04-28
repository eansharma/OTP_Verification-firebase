import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_otp_verfication/phone.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';


class MyOtp extends StatefulWidget {
  const MyOtp({Key? key}) : super(key: key);

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {

   final FirebaseAuth auth = FirebaseAuth.instance;
   int start = 30;

   @override
   void initState() {
     super.initState();
     startTimer();
   }



  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code ="";


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
      ),
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

              SizedBox(
                height: 10,
              ),
          Pinput(
            length: 6,
            onChanged: (value){
              code = value;
            },
            // defaultPinTheme: defaultPinTheme,
            // focusedPinTheme: focusedPinTheme,
            // submittedPinTheme: submittedPinTheme,
            // validator: (s) {
            //   return s == '2222' ? null : 'Pin is incorrect';
            // },
            // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            showCursor: true,
            // onCompleted: (pin) => print(pin),
          ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Send OTP again in ",
                            style: TextStyle(fontSize: 16, color: Colors.black)
                        ),
                        TextSpan(
                            text: start > 0 ? "00:$start sec" : "Resend",
                            style: TextStyle(fontSize: 16, color: Colors.red)
                        ),

                      ]
                  )

                  ),
                ],
              ),


              SizedBox(
                height: 20,
              ),

              SizedBox(
                height: 45,
                width: double.infinity,
                child:ElevatedButton(onPressed: () async{
                  // Create a PhoneAuthCredential with the code
                 try{
                   PhoneAuthCredential credential
                   = PhoneAuthProvider.credential(verificationId: MyPhone.verify, smsCode: code);
                   // Sign the user in (or link) with the credential
                   await auth.signInWithCredential(credential);

                   Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);

                 }catch(e){

                   print("Wrong otp");

                 }

                }, child: Text("Verify phone number"),
                  style: ElevatedButton.styleFrom(primary: Colors.green, shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  )),) ,
              ),
              Row(
                children: [
                  TextButton(onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                  },
                      child: Text('Edit Phone Number?', style: TextStyle(color: Colors.black),))

                ],
                
              )



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
