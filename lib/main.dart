import 'package:flutter/material.dart';
import 'package:rice_chat/product_detail_page.dart';

void main() {
  runApp(Detailpage());
}

class Detailpage extends StatelessWidget {
  const Detailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: ViewPage());
  }
}
