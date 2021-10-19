import 'dart:html';

import 'package:anert_portal/data/field_names.dart';
import 'package:firebase/firebase.dart';
import 'package:excel/excel.dart';

Future<List<int>> generator(
    String dataset, void Function(double) progress) async {
  // Queries data
  final db = database();
  final ref = db.ref(dataset);
  final data = (await ref.once('value')).snapshot;

  // Prepares .xlsl
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  final dataScheme = dataset == "EvData" ? evData : inspectionData;

  // Writes Data
  sheet.appendRow(dataScheme.values.toList());
  int count = 0;
  data.forEach((rowData) {
    var row = [];
    for (var element in dataScheme.keys) {
      row.add(rowData.child(element));
    }
    count++;
    progress(count * 100 / rowData.numChildren());
    sheet.appendRow(row);
  });

  return await excel.encode();
}
