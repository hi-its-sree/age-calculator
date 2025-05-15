import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ReviewPage extends StatefulWidget {
  ReviewPage({super.key, required this.reviewdetails});

  final List<Map<String, dynamic>> reviewdetails;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // Improved image decoding function
  Uint8List? decodeBase64ImageSafe(String? base64) {
    if (base64 == null || base64.isEmpty) return null;

    try {
      // Remove data URI prefix if present
      String cleanBase64 = base64.replaceFirst(RegExp(r'^data:image\/[^;]+;base64,'), '');

      // Remove any whitespace or newlines
      cleanBase64 = cleanBase64.replaceAll(RegExp(r'\s+'), '');

      // Ensure padding is correct (base64 padding should be a multiple of 4 characters)
      int padding = cleanBase64.length % 4;
      if (padding != 0) {
        cleanBase64 = cleanBase64.padRight(cleanBase64.length + (4 - padding), '=');
      }

      // Decode and return
      return base64Decode(cleanBase64);
    } catch (e) {
      if (kDebugMode) {
        print("Error decoding base64 image: $e");
        if (base64.length > 50) {
          print("Problematic base64 string (first 50 chars): ${base64.substring(0, 50)}...");
        } else {
          print("Problematic base64 string: $base64");
        }
      }
      return null;
    }
  }

  // Profile image widget
  Widget buildProfileImage(String? base64Image) {
    final Uint8List? imageBytes = decodeBase64ImageSafe(base64Image);

    if (imageBytes != null) {
      return ClipOval(
        child: Image.memory(
          imageBytes,
          width: 28,  // Reduced size to match your design
          height: 28,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return buildDefaultAvatar();
          },
        ),
      );
    } else {
      return buildDefaultAvatar();
    }
  }

  // Default avatar widget in case of no image
  Widget buildDefaultAvatar() {
    return CircleAvatar(
      radius: 13,  // Matches your design
      backgroundColor: Colors.grey[200],
      child: Icon(Icons.person, size: 15, color: Colors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.058,
              width: double.infinity,
              color: Colors.white60,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back, size: 23, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  Text("Reviews", style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500))
                ],
              ),
            ),
            Divider(height: 2.0, color: Colors.grey),

            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 5.0),
                      child: Row(
                        children: [
                          Icon(Icons.star, color: Colors.yellow.shade900),
                          Text("4.0 Reviews(${widget.reviewdetails.length})",
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: widget.reviewdetails.length, // Use actual review count
                        itemBuilder: (context, index) {
                          var review = widget.reviewdetails[index];
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              height: screenHeight * 0.178,
                              width: screenWidth * 0.900,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white30,
                                  border: Border.all(color: Colors.grey)
                              ),
                              child: Column(
                                children: [
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                     child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10.0),
                                            child: buildProfileImage(review['dp']),
                                          ), // Use the profile image builder
                                          SizedBox(width: screenWidth * 0.022),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                                            child: Text(review['name'] ?? 'Anonymous', // Use actual name
                                                style: TextStyle(fontWeight: FontWeight.w500)),
                                          ),
                                          Spacer(),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: Text(review['rating'] ?? '5.0', // Use actual rating
                                                style: TextStyle(fontWeight: FontWeight.w500)),
                                          ),
                                          SizedBox(width: 4),
                                          Icon(Icons.star, size: 16, color: Colors.yellow.shade900)
                                        ],
                                      ),
                                   ),

                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                              review['review'] ?? 'No review text', // Use actual review
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 6,
                                              textAlign: TextAlign.justify,
                                            )
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: screenHeight * 0.060,
                width: screenWidth * 0.90,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Book now",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                    SizedBox(width: screenWidth * 0.009),
                    Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 20)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
