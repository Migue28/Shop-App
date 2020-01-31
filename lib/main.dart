import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/products_detail_screen.dart';
import './providers/products_provider.dart';
import './providers/cart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ProductsProvider(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        debugShowCheckedModeBanner: false,
        home: ProductsOverviewScreeen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
        },
      ),
    );
  }
}
