import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentMode;

  final List<String> _paymentModes = [
    'Credit Card',
    'Debit Card',
    'Net Banking',
    'UPI',
    'Cash on Delivery',
    // Add more payment modes as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Info'),
        backgroundColor: Color(0xFFFFD700), // Yellow color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select Payment Mode:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _paymentModes.length,
                itemBuilder: (context, index) {
                  return RadioListTile<String>(
                    title: Text(_paymentModes[index]),
                    value: _paymentModes[index],
                    groupValue: _selectedPaymentMode,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMode = value;
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_selectedPaymentMode != null) {
                  // Set selected payment mode as default, e.g., save to preferences or database
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Default payment mode set to: $_selectedPaymentMode'),
                    ),
                  );
                } else {
                  // Show a message or handle scenario where no payment mode is selected
                }
              },
              child: Text('Set Default Payment Mode'),
            ),
          ],
        ),
      ),
    );
  }
}
