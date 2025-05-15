
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rentzy/BookingPages/BookingDetailsPage.dart';
import 'package:rentzy/BookingPages/PayWithUpi.dart';
import 'package:rentzy/BookingPages/PaymentStatus.dart';
import 'package:rentzy/HomePages/MainHome.dart';
import 'package:rentzy/HomePages/NewArrivals.dart';
import 'package:rentzy/HomePages/EmptyNotificationPage.dart';
import 'package:rentzy/HomePages/Reviews.dart';
import 'package:rentzy/HomePages/favourites.dart';
import 'package:rentzy/Notifications/local_notificatons.dart';
import 'package:rentzy/ProfilePages/ProfileSetup.dart';
import 'package:rentzy/Reset%20Password/EmailSent.dart';
import 'package:rentzy/pageSet-1/LetsUIn.dart';
import 'package:rentzy/pageSet-1/LoginScreen.dart';
import 'package:rentzy/pageSet-1/OnBoardingScreen2.dart';
import 'package:rentzy/pageSet-1/OnboardingScreen.dart';
import 'package:rentzy/pageSet-1/SignupScreen.dart';
import 'package:rentzy/pageSet-1/SplashScreenPage.dart';
import 'package:rentzy/pageSet-1/WelcomeScreen.dart';
import 'package:flutter/material.dart';
import 'BookingPages/ConfirmationPage.dart';
import 'BookingPages/PaymentMethodPages.dart';
import 'BottomNavBar/AddNewCard.dart';
import 'BottomNavBar/BottomNavigationBar.dart';
import 'BottomNavBar/CancellationPage.dart';
import 'BottomNavBar/ConfirmCancellationPage.dart';
import 'BottomNavBar/ContactUs.dart';
import 'BottomNavBar/FAQ.dart';
import 'BottomNavBar/HelpCenter.dart';
import 'BottomNavBar/Languages.dart';
import 'BottomNavBar/PaymentMethod.dart';
import 'BottomNavBar/PrivacyPolicy.dart';
import 'BottomNavBar/ProfilePages.dart';
import 'BottomNavBar/ReviewConfirmationPage.dart';
import 'BottomNavBar/ReviewPage.dart';
import 'BottomNavBar/Settings.dart';
import 'HomePages/CarDetailsPages.dart';
import 'HomePages/CategoryPage.dart';
import 'HomePages/NotificationPage.dart';
import 'HomePages/SearchPage.dart';
import 'Notifications/PushNotifications.dart';
import 'OrderPages/ActiveOrderDetailsPage.dart';
import 'OrderPages/OrderCompleted.dart';
import 'OrderPages/OrderTabs.dart';
import 'OrderPages/OrdersActive.dart';
import 'OrderPages/OrdersCancelled.dart';
import 'ProfilePages/EditProfile.dart';
import 'Reset Password/ForgotPassword.dart';
import 'firebase_options.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  await Notifications().initNotifications();
  await LocalNotification().initNotification();
  runApp(const CarRental());
}

class CarRental extends StatefulWidget {
  const CarRental({super.key});

  @override
  State<CarRental> createState() => _CarRentalState();
}

class _CarRentalState extends State<CarRental> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home:SplashScreenPage()

    );
  }
}






