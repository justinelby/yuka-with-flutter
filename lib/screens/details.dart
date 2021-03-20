import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:yuka/product.dart';
import 'package:yuka/ui/resources/app_images.dart';

import 'nutrition.dart';

class DetailsScreen extends StatelessWidget {
  final String barcode;
  DetailsScreen({required this.barcode});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Détails du produit'),
          bottom: TabBar(tabs: [Text('Détails'), Text('Nutrition')]),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<Product>(
                future: launchRequest(),
                initialData: null,
                builder:
                    (BuildContext context, AsyncSnapshot<Product> product) {
                  if (!product.hasData) {
                    return _Loading();
                  } else {
                    return _ProductContent(product: product.data!);
                  }
                }),
            NutritionalValues(),
          ],
        ),
      ),
    );
  }

  Future<Product> launchRequest() async {
    // On fait la requête
    http.Response networkResponse = await http.get(Uri.https(
        'api.formation-android.fr',
        'getProduct',
        <String, String>{'barcode': barcode}));

    // On décode le JSON
    dynamic json = jsonDecode(networkResponse.body);

    // On renvoie le tout dans un objet Product
    return Product.fromAPI(json['response']);
  }
}

/// Widget utilisé lorsqu'on charge le produit depuis le réseau
class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

/// Le contenu d'un produit
class _ProductContent extends StatelessWidget {
  final Product product;
  const _ProductContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _ProductContentThumbnail(product: product),
        SingleChildScrollView(
          child: _ProductContentBody(product: product),
        ),
      ],
    );
  }
}

class _ProductContentThumbnail extends StatelessWidget {
  _ProductContentThumbnail({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 180.0,
        child: product.picture != null
            ? Image.network(
                product.picture!,
                fit: BoxFit.cover,
              )
            : Placeholder());
  }
}

class _ProductContentBody extends StatelessWidget {
  _ProductContentBody({required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ProductContentBodyFirstLine(product: product),
          const SizedBox(height: 20.0),
          LabelValue(
            label: 'Code-barres',
            value: product.barcode,
          ),
          LabelValue(
            label: 'Quantité',
            value: product.quantity,
          ),
          LabelValue(
            label: 'Vendu en',
            value: product.manufacturingCountries?.join(', '),
          ),
          const SizedBox(height: 20.0),
          LabelValue(
            label: 'Ingrédients',
            value: product.ingredients
                ?.join(', '), /*product.ingredients?.split('_');*/
            //style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 20.0),
          LabelValue(
            label: 'Substances allergènes',
            value: product.allergens?.join(', '),
          ),
          const SizedBox(height: 20.0),
          LabelValue(
            label: 'Additifs',
            value: product.additives?.toString(),
          ),
/*          Text('ABCD'),
          Text('ABCD'),*/
        ],
      ),
    );
  }
}

class _ProductContentBodyFirstLine extends StatelessWidget {
  final Product product;

  _ProductContentBodyFirstLine({required this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                product.name ?? 'Barres glacées',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                product.brands?.join(', ') ?? 'Twix',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 68.0,
          height: 32.0,
          child: _nutriScoreImage != null
              ? Image.asset(_nutriScoreImage!)
              : Placeholder(),
        ),
      ],
    );
  }

  String? get _nutriScoreImage {
    switch (product.nutriScore?.toLowerCase()) {
      case 'a':
        return AppImages.nutriscoreA;
      case 'b':
        return AppImages.nutriscoreB;
      case 'c':
        return AppImages.nutriscoreC;
      case 'd':
        return AppImages.nutriscoreD;
      case 'e':
        return AppImages.nutriscoreE;
      default:
        return null;
    }
  }
}

// Affiche du contenu sous la forme "XXX : YYY"
class LabelValue extends StatelessWidget {
  final String label;
  final String? value;

  LabelValue({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: '$label : ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value ?? '-'),
        ],
      ),
    );
  }
}
