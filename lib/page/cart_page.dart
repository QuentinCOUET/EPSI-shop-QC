import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bo/Cart.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EPSI Shop"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: context
            .watch<Cart>()
            .articles
            .length > 0 ? ListCart() : EmptyCart(),
      ),
    );
  }
}

class EmptyCart extends StatelessWidget {
  const EmptyCart({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Votre panier total est de"),
            Text("0.00€")
          ],
        ),
        Spacer(),
        Text("Votre panier est actuellement vide"),
        Icon(Icons.image),
        Spacer()
      ],
    );
  }
}

class ListCart extends StatelessWidget {
  const ListCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cart>(
        builder: (context, cart, _) =>
            Column(
              children: [
                Text(cart.getPrixTotal().toString()),
                Flexible(child: ListView.builder(
                    itemCount: cart.articles.length,
                    itemBuilder: (context, index) =>
                        ListTile(
                          leading: Image.network(cart.articles[index].image),
                          title: Text(cart.articles[index].nom),
                          subtitle: Text(
                            cart.articles[index].getPrixEuro(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: TextButton(
                            onPressed: () =>
                                context.read<Cart>().removeArticle(
                                    cart.articles[index]),
                            child: const Text("Supprimer"),
                          ),
                        )
                ))
              ],
            )
    );
  }
}

