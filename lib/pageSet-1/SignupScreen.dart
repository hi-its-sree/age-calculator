import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rentzy/ProfilePages/ProfileSetup.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Database/UserDetails.dart';
import '../Authentication/Auth.dart';
import 'SplashScreenPage.dart';
import 'WelcomeScreen.dart';

List<String>logo=[
  "assets/images/Onboarding/google.svg",
  "assets/images/Onboarding/facebook.svg",
  "assets/images/Onboarding/apple.svg"
];

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<SignupScreen> {

  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  String password='';
  String email='';
  bool isVisible=true;
  final formKey=GlobalKey<FormState>();
  bool isChecked=false;

  @override
  void initState()
  {
    super.initState();
    emailcontroller.addListener(()=>setState(() {}));
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  Future<void>GoogleSignin() async
  {
    try
    {
      await Authentication().SigninWithGoogle();
    }
    catch(e)
    {
      print(e.toString());
    }
  }

  Future<void>SendDetails() async
  {
    try
    {
      await SaveDetails().userDetailsToFirestore(
          email:emailcontroller.text,
          password:passwordcontroller.text
      );
    }
    catch(e)
    {
      print(e);
    }

  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Authentication().createUserWithEmailAndPassword(
        email: emailcontroller.text,
        password: passwordcontroller.text,
      );
      await SendDetails();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileSetup()));
    } on FirebaseException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Email is invalid';
      } else if (e.code == 'wrong-password') {
        message = 'Invalid email or password';
      }
      else
      {
        message='Unknown error occured';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
        fontSize: 15,
      );
    } catch (e) {
      print("Generic Error: $e");  // Catch any other exceptions
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0,top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: ()
                        {
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back,size: 30,color: Colors.black,),)
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/Onboarding/car.png",height: 130,width: 150,)
                  ],
                ),
                SizedBox(height: 20,),
                Text("Create a new Account ",textAlign: TextAlign.center,style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 35,fontWeight: FontWeight.w600,color: Colors.black)),),
                SizedBox(height: 20,),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(

                          onChanged: (value)=>setState(() {
                            this.email=value;
                            print(email);

                          }),

                          validator: (value)
                          {
                            final pattern= RegExp(r'^[a-zA-Z0-9._%+-]+@[gmail\yahoo.]+\.[com]');

                            if(value!.isEmpty)
                            {
                              return 'Enter a email';
                            }

                            else if(!pattern.hasMatch(value!))
                            {
                              return 'Enter a valid email';
                            }
                            else
                            {
                              return null;
                            }
                          },

                          controller: emailcontroller,
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined,size: 25,),

                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red, width: 1.0),
                                borderRadius: BorderRadius.circular(13),
                              ),

                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0
                                ),
                              ),
                              errorStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.red),


                              suffixIcon:emailcontroller.text.isEmpty?
                              Container(width: 0,): IconButton(
                                  onPressed: ()
                                  {
                                    emailcontroller.clear();
                                  }, icon: Icon(Icons.close,size: 25,))
                              ,
                              hintText: 'Email',
                              hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.grey),

                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0
                                  ),
                                  borderRadius: BorderRadius.circular(13)
                              ),

                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2.0
                                  )
                              )
                          ),
                        ),

                        SizedBox(height: 20),

                        TextFormField(
                          validator: (value)
                          {
                            if(value!.length<8)
                            {
                              return 'Enter a valid password';
                            }
                            else
                            {
                              return null;
                            }
                          },

                          onFieldSubmitted: (value)=>setState(() {

                            FocusScope.of(context).unfocus();
                          }),
                          controller: passwordcontroller,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          obscureText: isVisible,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.grey),
                              prefixIcon: Icon(Icons.lock_outline_rounded,size: 25,color: Colors.black,),

                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0
                                ),
                              ),

                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0
                                ),
                              ),
                              errorStyle: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Colors.red),

                              suffixIcon: IconButton(
                                icon:isVisible?Icon(Icons.visibility_off,size: 25,color: Colors.black,):Icon(Icons.visibility,size: 25,color: Colors.black,),
                                onPressed: ()
                                {
                                  setState(() {
                                    isVisible=!isVisible;
                                  });

                                }, ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13),
                                  borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 1.0
                                  )
                              ),

                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(13),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0
                                ),

                              )
                          ),

                        ),
                        SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Remember me",style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.black))),
                            Checkbox(
                                checkColor: Colors.white,
                                activeColor: Colors.black,
                                value: isChecked, onChanged: (bool?value)
                            {
                              setState(() {
                                isChecked=value!;
                              });
                            })

                          ],
                        ),

                        SizedBox(height: 10,),

                        GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            final isValid=formKey.currentState!.validate();

                            if (isValid)
                            {
                              formKey.currentState!.save();
                              print("Email:${emailcontroller},Password:${passwordcontroller}");
                              createUserWithEmailAndPassword();
                            }
                            else
                              {
                                print("invalid data");
                              }
                          },
                          child: Container(
                            height: 50,
                            width: 380,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black
                            ),
                            child: Center(child: Text("Sign up",style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17,fontWeight: FontWeight.w500,color: Colors.white)),)),
                          ),
                        ),


                        SizedBox(height: 20,),

                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                                  indent: 15,
                                  color: Colors.black12,)
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text("or continue with ",style: GoogleFonts.lato(textStyle: TextStyle(color:Colors.black45,fontWeight: FontWeight.w500,fontSize: 17)),),
                            ),
                            Expanded
                              (child: Divider(
                                endIndent: 15,
                                color: Colors.black12)
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),

                SizedBox(
                  child: GridView.builder(
                      itemCount: 3,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 70.0,
                        childAspectRatio: 0.4,
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,),

                      itemBuilder: (context,index)
                      {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            child: InkWell(
                              onTap: ()
                              {
                                if(index==0)
                                  {
                                    GoogleSignin();
                                  }
                                else if(index==1)
                                  {
                                    GoogleSignin();
                                  }
                                else
                                  {
                                    GoogleSignin();
                                  }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(color: Colors.grey)
                                ),
                                child: Center(
                                  child: SvgPicture.asset(logo[index],height: 25,width: 30),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?",style: GoogleFonts.lato(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.black54)),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: ()
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Welcomescreen()));
                        },
                        child: GestureDetector(
                          onTap: ()
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Loginscreen()));
                          },
                          child: RichText(
                              text: TextSpan(
                                  text:"Sign in",
                                  style: GoogleFonts.lato(textStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  )))
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )),
    );
  }
}
