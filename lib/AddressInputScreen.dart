import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddressInputScreen extends StatefulWidget {
  @override
  _AddressInputScreenState createState() => _AddressInputScreenState();
}

class _AddressInputScreenState extends State<AddressInputScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roadStreetController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();

  List<Address> _savedAddresses = [];

  void _saveAddress() async {
    String url = 'http://127.0.0.1:8000/api/addresses/'; // Update to correct URL
    final response = await http.post(Uri.parse(url), body: {
      'name': _nameController.text,
      'roadStreet': _roadStreetController.text,
      'district': _districtController.text,
      'pincode': _pincodeController.text,
    });

    if (response.statusCode == 200) {
      print('Address saved');
      _clearInputFields();
      _fetchSavedAddresses();
    } else {
      print('Failed to save address');
    }
  }

  void _fetchSavedAddresses() async {
    String url = 'http://127.0.0.1:8000/api/addresses/'; // Update to correct URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<Address> addresses = [];
      final List<dynamic> json = jsonDecode(response.body);
      json.forEach((address) {
        addresses.add(Address(
          name: address['name'],
          roadStreet: address['roadStreet'],
          district: address['district'],
          pincode: address['pincode'],
        ));
      });

      setState(() {
        _savedAddresses = addresses;
      });
    } else {
      print('Failed to fetch addresses');
    }
  }

  void _clearInputFields() {
    _nameController.clear();
    _roadStreetController.clear();
    _districtController.clear();
    _pincodeController.clear();
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedAddresses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Address Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _roadStreetController,
              decoration: InputDecoration(
                labelText: 'Road / Street',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(
                labelText: 'District',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _pincodeController,
              decoration: InputDecoration(
                labelText: 'Pincode',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    _saveAddress();
                  },
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _clearInputFields();
                  },
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Display previously saved addresses
            Text(
              'Previously Saved Addresses:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: _savedAddresses.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Address Name: ${_savedAddresses[index].name}'),
                    subtitle: Text(
                      'Road / Street: ${_savedAddresses[index].roadStreet}, '
                      'District: ${_savedAddresses[index].district}, '
                      'Pincode: ${_savedAddresses[index].pincode}',
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

class Address {
  final String name;
  final String roadStreet;
  final String district;
  final String pincode;

  Address({
    required this.name,
    required this.roadStreet,
    required this.district,
    required this.pincode,
  });
}
