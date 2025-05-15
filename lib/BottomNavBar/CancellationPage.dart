import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentzy/BottomNavBar/ConfirmCancellationPage.dart';
import '../Database/BookingDetails.dart';

class CancellationPage extends StatefulWidget {
  const CancellationPage({super.key, required this.status, this.active});

  final Map<String, dynamic>? active;
  final String status;

  @override
  State<CancellationPage> createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  String? _selectedOption;
  bool _isProcessing = false;

  final List<String> _cancellationReasons = [
    'Change in Plans',
    'Found a better price',
    'No longer need a car',
    'Booking Error',
    'Provider Issues',
    'Vehicle Availability Issues',
    'Payment Issues',
    'Unexpected Circumstances',
    'Travel Restrictions',
    'Poor reviews',
    'Other',
  ];

  Future<void> _processCancellation() async {
    if (_selectedOption == null) return;

    setState(() => _isProcessing = true);

    try {
      // Calculate days
      final days = calculateRentalDays(
        pickupdate: widget.active?['pickupdate'] ?? '',
        returndate: widget.active?['returndate'] ?? '',
      )?.toString() ?? '0';

      // Get the booking ID from active data
      final bookingId = widget.active?['bookingId'];

      await BookingDetails().CancelledDetailsToFirestore(
        Fullname: widget.active?['Fullname'] ?? '',
        model: widget.active?['model'] ?? '',
        class_type: widget.active?['class'] ?? '',
        seats: widget.active?['seats']?.toString() ?? '',
        fuel_capacity: widget.active?['fuel_capacity']?.toString() ?? '',
        mileage: widget.active?['mileage']?.toString() ?? '',
        transmission: widget.active?['transmission'] ?? '',
        pickupdate: widget.active?['pickupdate'] ?? '',
        returndate: widget.active?['returndate'] ?? '',
        days: days,
        imageFile: widget.active?['profilePicture'] ?? '',
        location: widget.active?['location'] ?? '',
        rent: widget.active?['rent']?.toString() ?? '0',
        option: _selectedOption ?? '',
        bookingId: bookingId,
      );

      // Remove from Active collection if we have the bookingId
      if (bookingId != null && bookingId.isNotEmpty) {
        await BookingDetails().deleteActiveBooking(bookingId);
      }

      // Navigate to confirmation page
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmCancellationPage(
            status: widget.status,
            details: widget.active,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cancellation failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        title: const Text("Cancel Booking"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                "Rentzy",
                style: GoogleFonts.kaushanScript(
                  textStyle: TextStyle(
                    color: Colors.deepOrange,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Why are you cancelling?",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _cancellationReasons.length,
              itemBuilder: (context, index) {
                final reason = _cancellationReasons[index];
                return RadioListTile<String>(
                  activeColor: Colors.black,
                  title: Text(reason),
                  value: reason,
                  groupValue: _selectedOption,
                  onChanged: (value) => setState(() => _selectedOption = value),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(mediaQuery.size.width * 0.9, 50),
                backgroundColor: _selectedOption == null
                    ? Colors.grey
                    : Colors.black
              ),
              onPressed: _selectedOption == null || _isProcessing
                  ? null
                  : _processCancellation,
              child: _isProcessing
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                "Confirm Cancellation",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int? calculateRentalDays({
    required String pickupdate,
    required String returndate,
  }) {
    try {
      final pickupDate = DateTime.parse(pickupdate);
      final returnDate = DateTime.parse(returndate);
      return returnDate.difference(pickupDate).inDays + 1;
    } catch (e) {
      debugPrint('Date parsing error: $e');
      return null;
    }
  }
}