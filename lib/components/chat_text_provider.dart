import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

final chatTextProvider = Provider((ref) {
  TextEditingController _textEditingController = TextEditingController();
});
