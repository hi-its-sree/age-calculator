import 'package:flutter/material.dart';
class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor:Colors.grey.shade300,
      body: SafeArea(
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.058,
                width: double.infinity,
                color: Colors.white60,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back,
                          size: 23,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.053),
                    const Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),


                 Expanded(
                   child: SingleChildScrollView(
                     child: Padding(
                       padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
                       child: Column(
                          children: [
                            Row(
                              children: [
                                Text("1. Information We Collect",style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rentzy prioritizes your privacy while delivering a seamless car rental experience. We collect personal details such as your name, contact information, date of birth, and government-issued ID for identity verification and compliance with rental regulations. Optional profile photos enhance account personalization",textAlign: TextAlign.justify,style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15
                              ),),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("With your permission, we access real-time GPS location data for vehicle tracking and optimized rental coordination. Our practices ensure smooth operations while safeguarding your information. Let us know if you need further refinements! 🚗💨",textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15
                              ),),
                            ),

                            Row(
                              children: [
                                Text("2. How We Use Your Information",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rentzy uses your data to manage your account, verify identity, process rentals, and securely handle payments. We communicate essential updates and improve our services by analyzing usage trends, fixing issues, and personalizing recommendations. Additionally, we prioritize safety by detecting fraud, enforcing policies, and ensuring compliance with legal regulations. 🚗✨",textAlign: TextAlign.justify,style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15
                              ),),
                            ),

                            Row(
                              children: [
                                Text("3. How We Share Your Information",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rentzy does not sell your personal information but may share it with trusted third parties essential for providing our services. We work with secure payment processors, cloud storage providers, customer support tools, and identity verification services, ensuring strict confidentiality and limited data access. When renting vehicles from third-party providers, necessary booking details may be shared to complete transactions. Legal disclosures may occur if required by law or to prevent fraud. In the event of a merger or acquisition, user data may be transferred, with privacy remaining a priority.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("4. Data Security",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rentzy prioritizes your privacy with robust security measures, including encryption, secure storage, and restricted access. Regular audits help identify and mitigate risks. While we safeguard your data, we recommend using strong passwords and logging out on shared devices for added protection. 🚗🔒.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("5. Your Rights and Choices",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("You have rights over your personal data, including access, updates, and deletion. You can withdraw consent for certain data processing by adjusting your settings or contacting support. To opt out of promotional messages, use the unsubscribe link or account settings, though transactional emails may still be sent. To exercise your rights, contact us at website. we'll respond promptly in line with applicable laws.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("6. Children’s Privacy",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Rentzy’s services are not intended for individuals under the age of 18. We do not knowingly collect personal information from minors. If we become aware that we have collected data from a user under the age of 18, we will delete it immediately. Parents or guardians who believe their child has provided us with personal information can contact us for assistance.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("7. Cookies and Tracking Technologies",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("We use cookies and similar tracking technologies to enhance your experience on our app and website. Cookies help us remember your preferences, keep you logged in, and gather analytical data on how you use our platform. These insights help us improve functionality, detect issues, and offer relevant content.You can control or disable cookies through your browser settings, though doing so may affect your experience with certain features.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("8. Third-Party Links and Services",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Our app or website may contain links to third-party websites or services, such as insurance providers, payment gateways, or vehicle owner pages. These external services are not controlled by Rentzy, and we are not responsible for their content or privacy practices. We recommend reviewing their privacy policies before engaging with them.",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("9. Changes to This Privacy Policy",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("We may update this Privacy Policy from time to time to reflect changes in our services, technology, or legal requirements. If we make significant changes, we will notify you through the app, website, or via email. Your continued use of Rentzy after such updates constitutes your acceptance of the revised policy..",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),

                            Row(
                              children: [
                                Text("10. Contact Us",style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500
                                ),),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("""If you have any questions, concerns, or complaints about this Privacy Policy or our data practices, please reach out to us. We are happy to assist you.

Rentzy Privacy Team
📧 Email: rentzy@gmail.com
📞 Phone: 9025021303
🏢 Address: Nagercoil

""",textAlign: TextAlign.justify,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15
                                ),),
                            ),





                          ],
                        ),
                     ),
                   ),
                 ),
              
            ],
          )),
    );
  }
}
