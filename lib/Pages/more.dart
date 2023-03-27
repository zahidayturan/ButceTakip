import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../classes/appbar.dart';

class More extends ConsumerWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: appbarCustom(),
      body: Text("hello mada faka"),
    );
  }
}
