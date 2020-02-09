import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/app_drawer.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreeen extends StatefulWidget {
  @override
  _ProductsOverviewScreeenState createState() =>
      _ProductsOverviewScreeenState();
}

class _ProductsOverviewScreeenState extends State<ProductsOverviewScreeen> {
  bool _showFavorites = false;
  var _isInit = true;
  bool _isLoading = false;

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).fetchAndSetsProducts();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetsProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Lolis Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
              PopupMenuItem(
                child: Text('Favorites'),
                value: FilterOptions.Favorites,
              )
            ],
          ),
          Consumer<Cart>(
            builder: (
              _,
              cart,
              ch,
            ) =>
                Badge(
              child: ch,
              value: cart.totalItems.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: ProductsGrid(_showFavorites)),
    );
  }
}
