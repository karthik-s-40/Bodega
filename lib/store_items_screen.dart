import 'package:flutter/material.dart';

class StoreItemsScreen extends StatefulWidget {
  final String storeName;

  StoreItemsScreen({required this.storeName});

  @override
  _StoreItemsScreenState createState() => _StoreItemsScreenState();
}

class _StoreItemsScreenState extends State<StoreItemsScreen> {
  final List<Item> items = [
    Item(name: 'Apples', imagePath: 'images/apples.png', price: 15.99),
    Item(name: 'Bananas', imagePath: 'images/bananas.png', price: 10.49),
    // Add more items as needed
  ];

  final Map<Item, int> cart = {};

  void _addToCart(Item item, int quantity) {
    setState(() {
      cart[item] = (cart[item] ?? 0) + quantity;
    });
  }

  void _navigateToCartScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
        backgroundColor: Color(0xFFFFD700), // Yellow color
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: _navigateToCartScreen,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ItemTile(item: item, onAddToCart: _addToCart);
        },
      ),
    );
  }
}

class Item {
  final String name;
  final String imagePath;
  final double price; // Add price property

  Item({required this.name, required this.imagePath, required this.price});
}

class ItemTile extends StatefulWidget {
  final Item item;
  final Function(Item, int) onAddToCart;

  ItemTile({required this.item, required this.onAddToCart});

  @override
  _ItemTileState createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(widget.item.imagePath, width: 50, height: 50),
      title: Text(
        widget.item.name,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Increase font size and weight
      ),
      subtitle: Row(
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity--;
                });
              }
            },
          ),
          Text('$_quantity', style: TextStyle(fontSize: 18.0)), // Increase font size
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _quantity++;
              });
            },
          ),
          Text(
            '\₹${widget.item.price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18.0), // Increase font size
          ),
        ],
      ),
      trailing: ElevatedButton(
        onPressed: () {
          widget.onAddToCart(widget.item, _quantity);
        },
        child: Text('Add to cart'),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  final Map<Item, int> cart;

  CartScreen({required this.cart});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _proceedToCheckout(BuildContext context) {
    // Start the animation
    _animationController.forward().then((_) {
      // Navigate to order confirmation screen or handle post-animation logic
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OrderConfirmationScreen()),
        (Route<dynamic> route) => false, // Remove all routes until home
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Color(0xFFFFD700), // Yellow color
      ),
      body: ListView.builder(
        itemCount: widget.cart.length,
        itemBuilder: (context, index) {
          final item = widget.cart.keys.toList()[index];
          final quantity = widget.cart[item];
          return ListTile(
            leading: Image.asset(item.imagePath, width: 50, height: 50),
            title: Text(
              item.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), // Increase font size and weight
            ),
            subtitle: Text(
              'Quantity: $quantity',
              style: TextStyle(fontSize: 16.0), // Increase font size
            ),
            trailing: Text(
              '\₹${(item.price * quantity!).toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0), // Increase font size
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _proceedToCheckout(context),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Background color
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                ),
                child: Text('Proceed'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value * 2,
            child: FloatingActionButton(
              onPressed: () {
                _animationController.reset();
                _animationController.forward();
              },
              child: Icon(Icons.check),
            ),
          );
        },
      ),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmed'),
        backgroundColor: Color(0xFFFFD700), // Yellow color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Order Confirmed!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0),
            Icon(Icons.check_circle_outline, size: 100.0, color: Colors.green),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Back to Store'),
            ),
          ],
        ),
      ),
    );
  }
}
