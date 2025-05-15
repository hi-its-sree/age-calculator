import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:rentzy/BottomNavBar/ReviewConfirmationPage.dart';
import '../Database/Reviews.dart';

class UserReviewPage extends StatefulWidget {
  const UserReviewPage({
    super.key,
    required this.dp,
    required this.name,
    required this.model,
  });

  final String dp;
  final String name;
  final String model;

  @override
  State<UserReviewPage> createState() => _UserReviewPageState();
}

class _UserReviewPageState extends State<UserReviewPage> {
  double rating = 0;
  final reviewController = TextEditingController();
  bool isSubmitting = false;

  Future<void> reviewToFirebase() async {
    // Validate inputs
    if (rating == 0) {
      Fluttertoast.showToast(
        msg: "Please provide a rating!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
      );
      return;
    }

    if (reviewController.text.trim().isEmpty) {
      Fluttertoast.showToast(
        msg: "Please write a review!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black38,
        textColor: Colors.white,
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      await Reviews().ReviewstoFireStore(
        name: widget.name,
        dp: widget.dp,
        rating: rating.toString(),
        review: reviewController.text,
        model: widget.model,
      );

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ReviewConfirmationPage()),
        );
      }
    } catch (e) {
      if (mounted) {
        Fluttertoast.showToast(
          msg: "Failed to submit review: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black38,
          textColor: Colors.white,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final mediaQueryData = MediaQuery.of(context);
    final screenHeight = mediaQueryData.size.height;
    final screenWidth = mediaQueryData.size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              height: screenHeight * 0.058,
              width: double.infinity,
              color: Colors.white60,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Icon(
                        Icons.close,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  const Text(
                    "Rate & Review",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      "Rentzy",
                      style: GoogleFonts.kaushanScript(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Lottie Animation
                    Center(
                      child: Lottie.asset(
                        "assets/animations/Animation - 1746612511734 .json", // Ensure this file exists in pubspec.yaml
                        height: screenHeight * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                    // Rating Prompt
                    const Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Text(
                        "How was your rental experience?",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Rating and Review Section
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Column(
                        children: [
                          // Rating Bar
                          RatingBar.builder(
                            itemSize: 46,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 7.0),
                            updateOnDrag: true,
                            minRating: 1,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.yellow.shade800,
                            ),
                            onRatingUpdate: (newRating) {
                              setState(() {
                                rating = newRating;
                              });
                            },
                          ),
                          const SizedBox(height: 15),
                          // Review Prompt
                          const Text(
                            "Tell us more!",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                          // Review Text Field
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller: reviewController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              maxLines: 8,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white24,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.0,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    width: 1.0,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                hintText: "Write your review here...",
                                hintStyle: TextStyle(color: Colors.grey.shade600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Submit Button
                          GestureDetector(
                            onTap: isSubmitting ? null : reviewToFirebase,
                            child: Container(
                              height: screenHeight * 0.06,
                              width: screenWidth * 0.89,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: isSubmitting ? Colors.grey : Colors.black,
                              ),
                              child: Center(
                                child: isSubmitting
                                    ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                )
                                    : const Text(
                                  "Submit",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}