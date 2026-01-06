import 'package:butcetakip/features/addData/widgets/add_data_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../riverpod_management.dart';

class AddDataPage extends ConsumerWidget {
  const AddDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isIncome = ref.watch(addDataRiverpod.select((vm) => vm.isIncome));

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: null,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            AddDataHeader(label: isIncome ? "Gelir Ekle" : "Gider Ekle")
          ],
        ),
      ),
    );
  }
}

