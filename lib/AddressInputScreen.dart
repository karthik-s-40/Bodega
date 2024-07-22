import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
  Address? _selectedAddress;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _saveAddress() async {
    final address = Address(
      name: _nameController.text,
      roadStreet: _roadStreetController.text,
      district: _districtController.text,
      pincode: _pincodeController.text,
    );

    setState(() {
      _savedAddresses.add(address);
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('addresses', jsonEncode(_savedAddresses.map((a) => a.toJson()).toList()));

    _clearInputFields();
  }

  void _loadAddresses() async {
    final prefs = await SharedPreferences.getInstance();
    final String? addressesString = prefs.getString('addresses');

    if (addressesString != null) {
      final List<dynamic> addressesJson = jsonDecode(addressesString);
      setState(() {
        _savedAddresses = addressesJson.map((json) => Address.fromJson(json)).toList();
      });
    }
  }

  void _deleteAddress(int index) async {
    setState(() {
      _savedAddresses.removeAt(index);
    });

    final prefs = await SharedPreferences.getInstance();
    prefs.setString('addresses', jsonEncode(_savedAddresses.map((a) => a.toJson()).toList()));
  }

  void _clearInputFields() {
    _nameController.clear();
    _roadStreetController.clear();
    _districtController.clear();
    _pincodeController.clear();
  }

  void _setDefaultAddress() {
    if (_selectedAddress != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Default address set to: ${_selectedAddress!.name}')),
      );
    }
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
                  onPressed: _saveAddress,
                  child: Text('Save'),
                ),
                ElevatedButton(
                  onPressed: _clearInputFields,
                  child: Text('Clear'),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Previously Saved Addresses:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _savedAddresses.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _savedAddresses.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            '${_savedAddresses[index].name}, '
                            '${_savedAddresses[index].roadStreet}, '
                            '${_savedAddresses[index].district}, '
                            '${_savedAddresses[index].pincode}',
                          ),
                          leading: Radio<Address>(
                            value: _savedAddresses[index],
                            groupValue: _selectedAddress,
                            onChanged: (value) {
                              setState(() {
                                _selectedAddress = value;
                              });
                            },
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteAddress(index);
                            },
                          ),
                        );
                      },
                    ),
                  )
                : Text('No addresses saved yet.'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _setDefaultAddress,
              child: Text('Set as Default Address'),
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

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      name: json['name'],
      roadStreet: json['roadStreet'],
      district: json['district'],
      pincode: json['pincode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roadStreet': roadStreet,
      'district': district,
      'pincode': pincode,
    };
  }
}
