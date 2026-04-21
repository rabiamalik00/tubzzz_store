// Simple global cart state — can be replaced with Provider/Riverpod later

class CartItem {
  final String name;
  final String price;
  final String image;
  final String category;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    this.quantity = 1,
  });

  double get priceValue {
    return double.tryParse(price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;
  }

  double get totalPrice => priceValue * quantity;

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'image': image,
        'category': category,
        'quantity': quantity,
      };
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  void addItem(CartItem newItem) {
    final index = _items.indexWhere((item) => item.name == newItem.name);
    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(newItem);
    }
  }

  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
    }
  }

  void decreaseQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    }
  }

  void increaseQuantity(int index) {
    if (index >= 0 && index < _items.length) {
      _items[index].quantity++;
    }
  }

  void clear() => _items.clear();
}

// Global singleton instance
final cartManager = CartManager();