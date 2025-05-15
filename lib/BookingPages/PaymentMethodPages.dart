import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rentzy/BookingPages/PayWithUpi.dart';
import 'package:rentzy/BookingPages/PaymentStatus.dart';
import 'package:rentzy/OrderPages/OrdersActive.dart';
import '../Database/BookingDetails.dart';

class Paymentmethodpages extends StatefulWidget {
  const Paymentmethodpages({
    super.key,
    required this.days,
    required this.car,
    required this.name,
    required this.pickupdate,
    required this.returndate,
    required this.location
  });

  final int days;
  final Map<String, dynamic> car;
  final String name;
  final String pickupdate;
  final String returndate;
  final String location;

  @override
  State<Paymentmethodpages> createState() => PaymentmethodpagesState();
}

class PaymentmethodpagesState extends State<Paymentmethodpages> {
  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  final placecontroller = TextEditingController();
  final zipcontroller = TextEditingController();
  final expirycontroller = TextEditingController();
  final cvvcontroller = TextEditingController();

  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Payment Success: ${response.paymentId}');
    _saveBookingDetailsAndNavigate(
      status: 'success',
      paymentId: response.paymentId ?? 'N/A',
    );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Payment Error: ${response.message}, Code: ${response.code}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Payment failed: ${response.message ?? 'Unknown error'}"),
      ),
    );
    setState(() {
      _isProcessing = false;
    });
  }

  void _handleExternalWalletResponse(ExternalWalletResponse response) {
    print('External Wallet: ${response.walletName}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("External wallet selected: ${response.walletName ?? 'Unknown'}"),
      ),
    );
    setState(() {
      _isProcessing = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletResponse);
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    emailcontroller.dispose();
    numbercontroller.dispose();
    placecontroller.dispose();
    zipcontroller.dispose();
    expirycontroller.dispose();
    cvvcontroller.dispose();
    _razorpay.clear();
  }

  void PaymentProcess({
    required String name,
    required String email,
    required String model,
    required int amount,
    required String phone,
  }) {
    print('PaymentProcess Inputs: name=$name, email=$email, model=$model, amount=$amount, phone=$phone');
    var options = {
      'key': 'rzp_test_Hy63uFyzP7yl4j', // Replace with your valid test key
      'amount': amount, // Amount in paise
      'name': name.isEmpty ? 'Customer' : name,
      'description': model,
      'prefill': {
        'contact': phone,
        'email': email,
      },
      'retry': {
        'enabled': true,
        'max_count': 3,
      },
      'timeout': 300, // Payment timeout in seconds
    };
    print('Razorpay Options: $options');

    try {
      _razorpay.open(options);
    } catch (e) {
      print('Payment Initiation Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error initiating payment: $e")),
      );
      setState(() {
        _isProcessing = false;
      });
    }
  }

  bool _isProcessing = false;

  Future<void> sendActiveDetails() async {
    try {
      await BookingDetails().ActiveDetailsToFirestore(
        Fullname: namecontroller.text,
        model: widget.car['model'],
        class_type: widget.car['class'],
        seats:widget.car['seats'] ,
        fuel_capacity: widget.car['fuel capacity'],
        mileage: widget.car['mileage'],
        transmission: widget.car['transmission'],
        pickupdate: widget.pickupdate,
        returndate: widget.returndate,
        days: widget.days.toString(),
        imageFile: widget.car['image'],
        location: widget.location,
        rent: widget.car['rent'],
      );
    } catch (e) {
      print("Error sending active details: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save active order details")),
      );
    }
  }

  Future<void> sendCompletedDetails() async {
    try {
      await BookingDetails().CompletedDetailsToFirestore(
        Fullname: namecontroller.text,
        model: widget.car['model'],
        class_type: widget.car['class'],
        seats: widget.car['seats'],
        fuel_capacity: widget.car['fuel capacity'],
        mileage: widget.car['mileage'],
        transmission: widget.car['transmission'],
        pickupdate: widget.pickupdate,
        returndate: widget.returndate,
        days: widget.days.toString(),
        imageFile: widget.car['image'],
        location: widget.location,
        rent: widget.car['rent'],
      );
    } catch (e) {
      print("Error sending completed details: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save completed order details")),
      );
    }
  }

  Future<void> _saveBookingDetailsAndNavigate({
    required String status,
    required String paymentId,
  }) async {
    try {
      final isCompleted =
          widget.returndate == DateTime.now().toString().split(' ')[0];

      if (isCompleted) {
        await sendCompletedDetails();
      } else {
        await sendActiveDetails();
      }

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentStatus(
              car: widget.car,
              name: widget.name,
              pickupdate: widget.pickupdate,
              location: widget.location,
              days: widget.days,
              status: status,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving booking details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to save booking details: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
      }
    }
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
                      child: const Icon(
                        Icons.arrow_back,
                        size: 23,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  const Text(
                    "Payment methods",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.190,
                      width: screenWidth * 0.850,
                      child: Image.asset(
                        "assets/images/ForgotPassword/debitcard2.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Card Information",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        children: [
                          _buildTextField(
                            context: context,
                            controller: namecontroller,
                            label: "Full name",
                            hint: "John Doe",
                            icon: Icon(Icons.perm_identity),
                            keyboardType: TextInputType.text,
                          ),
                          _buildTextField(
                            context: context,
                            controller: emailcontroller,
                            label: "Email",
                            hint: "johndoe123@gmail.com",
                            icon: Icon(Icons.email_outlined),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _buildTextField(
                            context: context,
                            controller: numbercontroller,
                            label: "Card number",
                            hint: "0000 0000 0000 0000",
                            suffixIcon: Icon(CupertinoIcons.creditcard, color: Colors.grey),
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSmallTextField(
                                  context: context,
                                  controller: expirycontroller,
                                  hint: "MM/YY",
                                  width: screenWidth * 0.440,
                                ),
                                _buildSmallTextField(
                                  context: context,
                                  controller: cvvcontroller,
                                  hint: "CVV",
                                  width: screenWidth * 0.440,
                                  suffixIcon: Icon(Icons.credit_score_outlined, color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Country or Region",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          _buildTextField(
                            context: context,
                            controller: placecontroller,
                            label: "Country/region",
                            hint: "India",
                            icon: Icon(Icons.location_on_outlined),
                            keyboardType: TextInputType.text,
                          ),
                          _buildTextField(
                            context: context,
                            controller: zipcontroller,
                            label: "Zip",
                            hint: "000000",
                            keyboardType: TextInputType.number,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    indent: 23.5,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "Pay with card or",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                    endIndent: 23.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Paywithupi()),
                                );
                              },
                              child: Container(
                                height: screenHeight * 0.052,
                                width: screenWidth * 0.88,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0xFFcdcdcd),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/images/Logos/upi.png"),
                                    const Text(
                                      "Pay with UPI",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: _isProcessing
                                ? const CircularProgressIndicator()
                                : GestureDetector(
                              onTap: () {
                                if (!_isProcessing) {
                                  // Validate inputs
                                  if (namecontroller.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please enter your full name")),
                                    );
                                    return;
                                  }
                                  if (emailcontroller.text.isEmpty ||
                                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                          .hasMatch(emailcontroller.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please enter a valid email")),
                                    );
                                    return;
                                  }
                                  if (numbercontroller.text.isEmpty ||
                                      numbercontroller.text.length < 10) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Please enter a valid phone number")),
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _isProcessing = true;
                                  });
                                  try {
                                    final rent = widget.car['rent'] is String
                                        ? int.tryParse(widget.car['rent']) ?? 0
                                        : widget.car['rent'] is num
                                        ? (widget.car['rent'] as num).toInt()
                                        : 0;
                                    PaymentProcess(
                                      name: namecontroller.text,
                                      email: emailcontroller.text,
                                      model: "Payment for ${widget.car['model']}",
                                      amount: TotalAmount(rent, widget.days),
                                      phone: numbercontroller.text,
                                    );
                                  } catch (e) {
                                    print('Error processing payment: $e');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Error processing payment: $e")),
                                    );
                                    setState(() {
                                      _isProcessing = false;
                                    });
                                  }
                                }
                              },
                              child: Container(
                                height: screenHeight * 0.055,
                                width: screenWidth * 0.88,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "Continue",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(width: 8.0),
                                    Icon(
                                      Icons.arrow_forward_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ],
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

  Widget _buildTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String label,
    required String hint,
    Icon? icon,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.90,
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white30,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.grey,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red,
                width: 1.0,
                style: BorderStyle.solid,
              ),
            ),
            labelText: label,
            labelStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
            hintText: hint,
            hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15,
              color: Colors.grey,
            ),
            prefixIcon: icon,
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallTextField({
    required BuildContext context,
    required TextEditingController controller,
    required String hint,
    required double width,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.055,
      width: width,
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white30,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  int TotalAmount(int rent, int days) {
    print('Calculating TotalAmount: rent=$rent, days=$days');
    double total = (rent * days) + 950.00 + 20.00 + 75.00;
    double convertedAmount = total * 100;
    int finalAmount = convertedAmount.toInt();
    print('TotalAmount: $finalAmount paise');
    return finalAmount;
  }
}