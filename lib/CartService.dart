import 'Clothing.dart';

class CartService {
  static List<Clothing> cartItems = [];

  static List<Clothing> getCart() {
    return cartItems;
  }

  static Clothing getClothingById(int id) {
    return cartItems.firstWhere((element) => element.id == id);
  }

  static void addToCart(Clothing clothing) {
    if (cartItems == null) {
      cartItems = [];
    }
    Clothing existingItem = cartItems.firstWhere(
        (item) => item.id == clothing.id,
        orElse: () => Clothing(
            id: '',
            name: '',
            imageUrl: '',
            size: '',
            price: '',
            category: '',
            description: '',
            quantity: 0));
    if (existingItem.id.isNotEmpty) {
      existingItem.quantity++;
    } else {
      cartItems.add(clothing);
    }
    print(
        'New total: ${getCartTotal()}'); // afficher le nouveau total à chaque ajout
  }

  static void decrementItem(Clothing clothing) {
    int index = cartItems.indexOf(clothing);
    if (cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
    } else {
      removeFromCart(clothing);
    }
  }

  static void removeFromCart(Clothing clothing) {
    cartItems.remove(clothing);
  }

  static int getCartItemCount() {
    int itemCount = 0;
    for (Clothing item in cartItems) {
      itemCount += item.quantity;
    }
    return itemCount;
  }

  static double getCartTotal() {
    double total = 0.0;
    for (Clothing item in cartItems) {
      total += double.parse(item.price) * item.quantity;
    }
    return total;
  }

  static void clearCart() {
    cartItems.clear();
  }
}
