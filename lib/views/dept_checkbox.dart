import 'package:flutter/material.dart';

class DeptCheckBox extends StatefulWidget {
  var itemCheck = new List.filled(4, false, growable: false);
  String deptName = "";

  DeptCheckBox(this.itemCheck, this.deptName, {super.key});

  @override
  State<DeptCheckBox> createState() => _DeptCheckBoxState(itemCheck, deptName);
}

class _DeptCheckBoxState extends State<DeptCheckBox> {
  var itemCheck = new List.filled(4, false, growable: false);
  String deptName = "";

  _DeptCheckBoxState(var this.itemCheck, this.deptName);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("${deptName}"),
        for (var i = 0; i < itemCheck.length; i++)
          CheckboxListTile(
            title: (i == 0)
                ? const Text('1st Year')
                : (i == 1)
                    ? const Text('2nd Year')
                    : (i == 2)
                        ? const Text('3rd Year')
                        : const Text('4th Year'),
            value: itemCheck[i],
            onChanged: (newValue) {
              setState(() {
                itemCheck[i] = newValue!;
              });
            },
          ),
      ],
    );
  }
}
