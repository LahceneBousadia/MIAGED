  import 'package:flutter/material.dart';
  import 'Clothing.dart';
  import 'CartService.dart';
  import 'CartPage.dart';

  class ClothingDetailPage extends StatelessWidget {
    final Clothing clothing;

    const ClothingDetailPage({required this.clothing});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(clothing.name),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.network(
                    clothing.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                clothing.name,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                '\€${clothing.price}',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Taille: ${clothing.size}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: Text(
                  clothing.description,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    CartService.addToCart(clothing);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Ajouté au panier'),
                          content: Text('Vêtement ajouté au panier.'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Continuer'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('Aller au panier'),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage(
                                            cartItems: CartService.getCart())));
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text(
                    'Ajouter au panier',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFFFFA000),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
