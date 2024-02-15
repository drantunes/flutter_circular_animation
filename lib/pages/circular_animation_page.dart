import 'package:flutter/material.dart';

class CircularAnimationPage extends StatefulWidget {
  const CircularAnimationPage({super.key});

  @override
  State<CircularAnimationPage> createState() => _CircularAnimationPageState();
}

class _CircularAnimationPageState extends State<CircularAnimationPage> {
  List<bool> items = [];
  int totalItems = 10;
  int checkedItems = 0;
  double lastValue = 0;
  double currentValue = 0;

  @override
  void initState() {
    super.initState();
    items = List.generate(totalItems, (_) => false);
  }

  changeProgress() {
    setState(() {
      checkedItems = items.where((element) => element).length;
      lastValue = currentValue;
      currentValue = checkedItems / totalItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: lastValue, end: currentValue),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, value, _) => CircularProgressIndicator(
                    value: value,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                Text(
                  (checkedItems).toStringAsFixed(0),
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Center(
        child: ListView(
          children: List.generate(
            totalItems,
            (index) => CheckboxListTile(
              value: items[index],
              onChanged: (val) {
                items[index] = val!;
                changeProgress();
              },
              title: Text('Item $index'),
            ),
          ),
        ),
      ),
    );
  }
}
