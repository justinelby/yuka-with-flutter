// Code du bloc

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../product.dart';

class ProductFetcherBloc
    extends Bloc<ProductFetcherEvent, ProductFetcherState> {
  ProductFetcherBloc(String barcode) : super(ProductFetcherStateLoading()) {
    add(ProductFetcherEvent(barcode));
  }

  @override
  Stream<ProductFetcherState> mapEventToState(
      ProductFetcherEvent event) async* {
    if (event is ProductFetcherEvent) {
      String barcode = event.barcode;

      yield ProductFetcherStateLoading();
      Product product = await launchRequest(barcode);

      yield ProductFetcherStateSuccess(product);
    }
  }

  Future<Product> launchRequest(String barcode) async {
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

class ProductFetcherEvent {
  final String barcode;

  ProductFetcherEvent(this.barcode);
}

abstract class ProductFetcherState {}

class ProductFetcherStateLoading extends ProductFetcherState {}

class ProductFetcherStateSuccess extends ProductFetcherState {
  final Product product;

  ProductFetcherStateSuccess(this.product);
}
