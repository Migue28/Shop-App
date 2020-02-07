import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(
    this.id,
    this.title,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  EditProductScreen.routeName,
                  arguments: id,
                );
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                bool borrar = false;
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text('Do you want to remove this product?'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          borrar = false;
                          Navigator.of(context).pop();
                        },
                        child: Text('No'),
                      ),
                      FlatButton(
                        onPressed: () {
                          borrar = true;

                          Provider.of<ProductsProvider>(context, listen: false)
                              .deleteProduct(id);

                          Navigator.of(context).pop();
                        },
                        child: Text('Sí'),
                      ),
                    ],
                  ),
                );
              },
              color: Theme.of(context).errorColor,
            )
          ],
        ),
      ),
    );
  }
}
