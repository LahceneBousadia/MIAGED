import 'package:flutter/material.dart';
import 'Clothing.dart';
import 'CartService.dart';

class CartPage extends StatefulWidget {
  final List<Clothing> cartItems;

  CartPage({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartService _cartService = CartService();
  double _total = 0.0; // ajouter une variable pour stocker le total

  @override
  void initState() {
    super.initState();
    _updateTotal(); // appeler la méthode _updateTotal dans la méthode initState
  }

  void _updateTotal() {
    setState(() {
      _total = CartService.getCartTotal();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Clothing> cartItems = CartService.getCart();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mon panier',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Le panier est vide'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.network(
                          cartItems[index].imageUrl,
                          width: 100,
                          height: 100,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItems[index].name,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '${cartItems[index].price}€',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Row(
                                children: [
                                  Text(
                                    'Quantité: ',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.remove),
                                    onPressed: () {
                                      setState(() {
                                        CartService.decrementItem(
                                            cartItems[index]);
                                        _updateTotal(); // mettre à jour le total après la modification
                                      });
                                    },
                                  ),
                                  Text(
                                    '${cartItems[index].quantity}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        CartService.addToCart(cartItems[index]);
                                        _updateTotal(); // mettre à jour le total après l'ajout
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              CartService.removeFromCart(cartItems[index]);
                              _updateTotal(); // mettre à jour le total après la suppression
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total: ${_total.toStringAsFixed(2)}€',
                  style: TextStyle(fontSize: 20.0),
                ),
                ElevatedButton(
                  onPressed: () {
                    CartService.clearCart();
                    setState(() {
                      _total =
                          0.0; // mettre à jour le total à zéro après la suppression
                    });
                  },
                  child: Text(
                    'Vider le panier',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[900],
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
