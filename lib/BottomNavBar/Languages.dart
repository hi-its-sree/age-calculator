import 'package:flutter/material.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  List<String> option = ['English (US)', 'English (UK)', 'Tamil', 'Malayalam', 'Hindi', 'Telugu', 'Kannada'];
  String currentOption = 'English (US)';

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
                    "Languages",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 15.0),
              child: Row(
                children: [
                  const Text(
                    "Suggested",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: option.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(option[index]),
                    trailing: Radio(
                      value: option[index],
                      groupValue: currentOption,
                      activeColor: Colors.black,
                      splashRadius: 5.0,
                      onChanged: (value) {
                        setState(() {
                          currentOption = value.toString();
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
