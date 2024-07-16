import 'package:flutter/material.dart';
import 'AddressInputScreen.dart'; // Import your AddressInputScreen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bodega',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 225, 225, 161), // Yellow for the AppBar
        scaffoldBackgroundColor: Color.fromARGB(255, 247, 247, 246), // White background
        brightness: Brightness.light, // Light theme
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.black),
          headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/', // Initial route
      routes: {
        '/': (context) => MyHomePage(title: 'Bodega'), // Home route
        '/addresses': (context) => AddressInputScreen(), // Route for Addresses screen
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  final List<Store> stores = [
    Store(name: 'Jio Mart', iconPath: 'images/store_a_icon.png'),
    Store(name: 'Fresh Mart', iconPath: 'images/store_b_icon.png'),
    Store(name: 'Green Mart', iconPath: 'images/store_c_icon.png'),
    // Add more stores as needed
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _showCurrentLocation() {
    // Add logic to show current location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Color(0xFFFFD700), // Yellow color
        actions: [
          IconButton(
            icon: Icon(Icons.location_on, size: 30.0), // Larger location icon
            onPressed: () {
              _showCurrentLocation(); // Show location on click
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 225, 225, 161), // Yellow color for drawer header
              ),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Home or handle action
              },
            ),
            ListTile(
              title: Text('Orders'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Orders or handle action
              },
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Settings or handle action
              },
            ),
            ListTile(
              title: Text('Addresses'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.pushNamed(context, '/addresses'); // Navigate to Addresses screen
              },
            ),
            ListTile(
              title: Text('Payment info'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Payment info or handle action
              },
            ),
            ListTile(
              title: Text('FAQs'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to FAQs or handle action
              },
            ),
            ListTile(
              title: Text('Contact us'),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Navigate to Contact us or handle action
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: stores.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(stores[index].iconPath),
                radius: 40, // Adjust as needed
              ),
              title: Text(
                stores[index].name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold), // Increase font size
              ),
              onTap: () {
                // Navigate to store details or handle tap action
                // Example: Navigator.pushNamed(context, '/store-details', arguments: stores[index]);
              },
            ),
          );
        },
      ),
    );
  }
}

class Store {
  final String name;
  final String iconPath;

  Store({required this.name, required this.iconPath});
}
