import 'package:flutter/material.dart';
import 'package:rentzy/BottomNavBar/AddNewCard.dart';
import '../Database/CardDetails.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  List<Map<String, dynamic>> cards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCardDetails();
  }

  Future<void> _loadCardDetails() async {
    try {
      final fetchedCards = await CardDetails().fetchAllData();
      setState(() {
        cards = fetchedCards;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading cards: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back, size: 23, color: Colors.black),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.053),
                  const Text("Payment Methods",
                      style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
                ],
              ),
            ),

            // Payment Options
            _buildPaymentOption(screenHeight, screenWidth,
                "assets/images/Logos/phonepe.png", "PhonePe"),
            SizedBox(height: screenHeight * 0.018),
            _buildPaymentOption(screenHeight, screenWidth,
                "assets/images/Logos/paytm.png", "Paytm"),
            SizedBox(height: screenHeight * 0.030),

            // Cards List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : cards.isEmpty
                  ? const Center(
                child: Text("No saved cards found.",
                    style: TextStyle(fontSize: 16)),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 8.0),
                    child: _buildCardItem(cards[index], index,),
                  );
                },
              ),
            ),

            // Add New Card Button
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNewCard()),
                  );

                  //refresh the list
                  await _loadCardDetails();
                },
                child: Container(
                  height: screenHeight * 0.055,
                  width: screenWidth * 0.88,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.black,
                  ),
                  child: const Center(
                    child: Text("Add New Card",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(
      double height, double width, String imagePath, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Container(
        height: height * 0.090,
        width: width * 0.890,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.black12,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.asset(imagePath),
              SizedBox(width: width * 0.0203),
              Text(title,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black)),
              const Spacer(),
              const Text("Connected",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCardItem(Map<String, dynamic> cardData, int index) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: 75,
      width: 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.black12,
      ),
      child: Row(
        children: [
          const Icon(Icons.credit_card, size: 40, color: Colors.grey),
          SizedBox(width: screenWidth * 0.05),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Card ${index + 1}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "•••• •••• •••• ${cardData['cardnumber']?.toString().substring(cardData['cardnumber'].toString().length - 4) ?? '••••'}",
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteCard(cardData['id']),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteCard(String cardId) async {
    try {
      await CardDetails().deleteCard(cardId);
      await _loadCardDetails(); // Refresh the list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Card deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting card: $e')),
      );
    }
  }
}