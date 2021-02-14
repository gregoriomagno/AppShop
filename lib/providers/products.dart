import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;

  bool _showFavoriteOnly = false;

  List<Product> get items => [..._items];
  List<Product> get favoriteItems =>
      [..._items.where((prod) => prod.isFavorite).toList()];

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners();
  }
}

// void showFavoriteOnly(){
//   _showFavoriteOnly = true;
//   notifyListeners();
// }
// void showAll(){
//   _showFavoriteOnly = false;
//   notifyListeners();
// }
