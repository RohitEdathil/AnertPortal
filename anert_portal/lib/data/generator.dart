import 'package:anert_portal/data/field_names.dart';
import 'package:firebase/firebase.dart';
import 'package:excel/excel.dart';

Future<List<int>?> generator(String dataset) async {
  // Queries data
  final db = database();
  final ref = db.ref(dataset);
  final data = (await ref.once('value')).snapshot;

  // Prepares .xlsx
  final excel = Excel.createExcel();
  final sheet = excel['Sheet1'];
  final dataScheme = dataset == "EvSite" ? evData : inspectionData;

  // Writes row headers
  sheet.appendRow(dataScheme.values.toList());

  // Prepares row data
  data.forEach((rowData) {
    List row = [];
    // Checks if suitable
    if (rowData.child("suitable").val() == "no") {
      // Adds only allowed fields
      for (var element in dataScheme.keys) {
        if (fieldsInNo.contains(element)) {
          row.add(rowData.child(element).val());
        } else {
          row.add("");
        }
      }
    } else {
      // Adds every fields
      for (var element in dataScheme.keys) {
        row.add(rowData.child(element).val());
      }
    }

    // Replaces strings mentioned in replacements
    List replaced = [];
    for (var ele in row) {
      if (replacements.containsKey(ele)) {
        replaced.add(replacements[ele]);
      } else {
        replaced.add(ele);
      }
    }

    // Writes row to file
    sheet.appendRow(replaced);
  });

  return excel.encode();
}
