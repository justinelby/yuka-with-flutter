import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:yuka/icons.dart';
import 'package:yuka/ui/resources/app_images.dart';
import 'package:yuka/widgets/appbar.dart';
import 'package:yuka/widgets/button.dart';

import 'details.dart';

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: OFFAppBar(
        title: 'Mes produits',
      ),
      body: ProductsList(),
    );
  }
}

class EmptyList extends StatelessWidget {
  EmptyList();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(AppImages.icEmptyList),
          const SizedBox(height: 50.0),
          Text(
            'T1',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 50.0),
          OFFButton(
            text: 'Scanner un produit',
            onPressed: () {
              onButtonClicked(context);
            },
          )
        ],
      ),
    );
  }

  void onButtonClicked(BuildContext context) async {
    String? barcode = await FlutterBarcodeScanner.scanBarcode(
      '#ff6666',
      'Annuler',
      true,
      ScanMode.BARCODE,
    );

    if (barcode != null) {
      Navigator.of(context).push(
        MaterialPageRoute<Object>(
          builder: (BuildContext context) => DetailsScreen(barcode: barcode),
        ),
      );
    }
  }
}

class ProductsList extends StatelessWidget {
  final List<MinimalProduct> products = <MinimalProduct>[
    MinimalProduct(
        barcode: '5000159484695',
        name: 'Twix Barres Glacées',
        brand: 'Twix',
        nutriscore: MinimalProductNutriscore.a,
        picture:
            'https://static.openfoodfacts.org/images/products/500/015/948/4695/front_fr.13.400.jpg'),
    MinimalProduct(
        barcode: '5000159484695',
        name: 'Twix Barres Glacées',
        brand: 'Twix',
        nutriscore: MinimalProductNutriscore.a,
        picture:
            'https://static.openfoodfacts.org/images/products/500/015/948/4695/front_fr.13.400.jpg'),
    MinimalProduct(
        barcode: '5000159484695',
        name: 'Twix Barres Glacées',
        brand: 'Twix',
        nutriscore: MinimalProductNutriscore.a,
        picture:
            'https://static.openfoodfacts.org/images/products/500/015/948/4695/front_fr.13.400.jpg'),
    MinimalProduct(
        barcode: '5000159484695',
        name: 'Twix Barres Glacées',
        brand: 'Twix',
        nutriscore: MinimalProductNutriscore.a,
        picture:
            'https://static.openfoodfacts.org/images/products/500/015/948/4695/front_fr.13.400.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      isAlwaysShown: true,
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int position) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProductListItem(
              product: products[position],
            ),
          );
        },
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final MinimalProduct product;

  ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: 15.0,
        start: 10.0,
        end: 10.0,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<Object>(
              builder: (BuildContext context) =>
                  DetailsScreen(barcode: product.barcode),
            ),
          );
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: 150.0,
                child: Image.network(
                  product.picture,
                  fit: BoxFit.cover,
                ),
              ),
              Text(product.name),
              Text(product.brand),
              Row(
                children: <Widget>[
                  Icon(
                    AppIcons.leaderboard,
                    size: 10.0,
                  ),
                  const SizedBox(width: 10.0),
                  Text('Nutriscore : ${_formatNutriscoreValue()}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatNutriscoreValue() {
    switch (product.nutriscore) {
      case MinimalProductNutriscore.a:
        return 'A';
      case MinimalProductNutriscore.b:
        return 'A';
      case MinimalProductNutriscore.c:
        return 'A';
      case MinimalProductNutriscore.d:
        return 'A';
      case MinimalProductNutriscore.e:
        return 'A';
      case MinimalProductNutriscore.unknown:
        return 'Inconnu';
    }
  }
}

class MinimalProduct {
  final String barcode;
  final String name;
  final String brand;
  final MinimalProductNutriscore nutriscore;
  final String picture;

  MinimalProduct(
      {required this.barcode,
      required this.name,
      required this.brand,
      required this.nutriscore,
      required this.picture});
}

enum MinimalProductNutriscore { a, b, c, d, e, unknown }
