import 'package:flutter/material.dart';

Widget buildLoader() {
  return Center(
      child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        CircularProgressIndicator(),
        Padding(padding: EdgeInsets.only(top: 5), child: Text('Loading data'))
      ]));
}
