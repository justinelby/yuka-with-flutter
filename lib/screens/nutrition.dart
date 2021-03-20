import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yuka/widgets/circle.dart';

class NutritionScreen extends StatefulWidget {
  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Repères nutritionnels pour 100g'),
        SingleChildScrollView(
          child: NutritionalValues(),
        ),
      ],
    );
  }
}

class NutritionalValues extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10.0),
            Text('Repères nutritionnels pour 100g',
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 30.0),
            Row(
              children: [
                OFFCircleWidget(
                  color: Colors.yellow,
                  size: 30.00,
                ),
                const SizedBox(width: 10.0),
                Text('14.2 de Matières grasses / lipides en quantité élevée'),
              ],
            ),
            const SizedBox(height: 20.0),
            Row(children: [
              OFFCircleWidget(
                color: Colors.red,
                size: 30.00,
              ),
              const SizedBox(width: 10.0),
              Text('29.2 de Sucres en quantité élevée')
            ]),
            const SizedBox(height: 20.0),
            Row(
              children: [
                OFFCircleWidget(
                  color: Colors.yellow,
                  size: 30.00,
                ),
                const SizedBox(width: 10.0),
                Text('0.3 de Sel en quantité élevée')
              ],
            )
          ],
        ));
  }
}
