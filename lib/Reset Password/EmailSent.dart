import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
class EmailSent extends StatefulWidget {
  const EmailSent({super.key, required this.email});
  final  String email;

  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:10.0,top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.black,),),
                     
                    ],
                  ),
                ),
                SizedBox(height:50),
                Image.asset("assets/images/ForgotPassword/emailsent.jpg",height: 320,width: 320,fit: BoxFit.cover,),
                SizedBox(height: 15,),
                Text("Password Reset Email Sent!!",style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.w800,color: Colors.black)),),
                SizedBox(height: 10,),
                Text(widget.email,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black))),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Success! A password reset link has been sent to your email. Check your inbox to reset your password and get back on the road with Rentzy!🚗📧",textAlign: TextAlign.center
                    ,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.w400,color: Colors.grey.shade600))),
                ),
                SizedBox(height: 20,),
                MaterialButton(
                    onPressed: ()
                {
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Loginscreen()));
                },
                color: Colors.black,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                ),
                height: 45,
                minWidth: 250,
                splashColor:Colors.grey.shade800,
                child: Text("Done",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
            
                )],
            ),
          )),
    );
  }
}

