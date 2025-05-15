import 'package:rentzy/pageSet-1/LetsUIn.dart';
import 'package:rentzy/pageSet-1/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<String>image_url=
["assets/images/Onboarding/onboard1.png",
  "assets/images/Onboarding/onboard2.png",
  "assets/images/Onboarding/onboard3.png"];

List<String>title=[
  "Ride Your Way – Affordable, Luxurious & Safe!",
  "Pay Your Way – Flexible & Affordable!",
  "We’ve Got Your Back – 24/7 Roadside Assistance!",
];

List<String>description=[
  "From budget to luxury, find your perfect ride! 🚗💨 Affordable rentals, premium cars, family-friendly SUVs, and 24/7 roadside support—ride with confidence",
  "Pay your way—UPI, Debit/Credit Cards, Wallets, or Cash! Choose hourly, daily, or weekly rentals with no hidden charges. Pay only for what you use!",
  "Stuck on the road? Get instant support anytime, anywhere—just a tap away!",
];



class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {

  late PageController pageController;
  int pageIndex =0;

  @override
  void initState()
  {
    pageController=PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose()
  {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index)=>
                          setState(() {
                            pageIndex=index;
                          }),
                      itemCount:3,
                      itemBuilder: (context,index)=>
                          OnBoardingScreenContent(
                            image:image_url[index],
                            title: title[index],
                            description: description[index],
                          )
                  ),
                ),


                Row(
                  children: [
                    SizedBox(width: 10,),
                    ...List.generate(image_url.length, (index)=>
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Indicator(isActive: index==pageIndex),
                        ),),

                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade400,
                        ),
                        child: Center(
                            child:IconButton(
                              onPressed: ()
                              {
                                if (pageIndex==image_url.length-1)
                                {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>LetsUIn()));
                                }
                                else
                                {
                                  pageController.nextPage(
                                      duration: Duration(milliseconds: 350), curve: Curves.ease);
                                }
                              },
                              icon: Icon(Icons.arrow_forward,size: 25,),)
                        ),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          )

      ),
    );
  }
}


//Indicator content
class Indicator extends StatelessWidget {
  const Indicator({
    this.isActive=false,
    super.key,
  });


  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: isActive? 15:7,
      width: 5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: isActive?Colors.black:Colors.grey
      ),
    );
  }
}


//ScreenContent

class OnBoardingScreenContent extends StatelessWidget {
  const OnBoardingScreenContent({
    super.key, required this.image, required this.title, required this.description,
  });

  final image;
  final title;
  final description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(image,fit: BoxFit.cover,),
        Spacer(),
        Text(title,textAlign: TextAlign.center,style: GoogleFonts.dmSans(textStyle: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),)  ),
        SizedBox(height: 20,),
        Text(description,textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),),
        Spacer()
      ],
    );
  }
}
