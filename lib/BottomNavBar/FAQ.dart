import 'package:flutter/material.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  Widget build(BuildContext context) {
    var mediaquerydata = MediaQuery.of(context);
    var screenHeight = mediaquerydata.size.height;
    var screenWidth = mediaquerydata.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "1. What is Rentzy and how does it work?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Rentzy is a car rental mobile app that allows you to browse, book, and manage car rentals easily. Just sign up, choose a car, select your rental period, and drive.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: screenHeight*0.0134,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "2. Who can use Rentzy?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Anyone aged 18 or older with a valid driving license can use Rentzy, subject to local laws and verification.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: screenHeight*0.0134,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "3. What types of cars can I rent through Rentzy?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "We offer a range of vehicles from hatchbacks and sedans to SUVs and luxury cars. Availability depends on your selected location and dates.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: screenHeight*0.0134,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "4. How do I contact Rentzy support?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "You can reach us through the Help & Support section in the app or by emailing support@rentzy.com.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: screenHeight*0.0134,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "5. I forgot my password. How can I reset it?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Tap on 'Forgot Password' on the login screen, and we’ll send you a link to reset it via email or SMS.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: screenHeight*0.0134,),
              
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "6. Can I update my personal details after registration?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Yes, go to the Profile section in the app to update your name, contact details, and documents.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight*0.0134,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "7. What if the car breaks down during my trip?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Contact our 24/7 roadside assistance through the app. We’ll arrange for help or a replacement vehicle.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight*0.0134,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "8. Who is responsible for car damage?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "If damage occurs during your rental, you may be liable depending on the insurance coverage selected. Please read our damage policy.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight*0.0134,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "9. What should I do in case of an accident?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "Ensure everyone’s safety first, then contact emergency services if needed. Inform Rentzy support immediately through the app.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight*0.0134,),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      width: screenWidth * 0.90,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(style: BorderStyle.none)
                      ),
                      child: Theme(
                        data: ThemeData(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          backgroundColor: Colors.grey.shade200,
                          collapsedBackgroundColor: Colors.grey.shade200,
                          title: Text(
                            "10. How do I delete my Rentzy account?",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black,
                              letterSpacing: 0.5,
                            ),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 17.0,vertical: 5.0),
                              child: Text(
                                "You can request account deletion from the Profile section > Settings > Delete Account, or by contacting our support team.",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
