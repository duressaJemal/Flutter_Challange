import 'package:flutter/material.dart';
import 'package:santas_list/domain/models/status.dart';

class ChildListTile extends StatelessWidget {
  String name;
  String country;
  Status status;
  Function onTap;
  ChildListTile(
      {required this.name,
      required this.country,
      required this.status,
      required this.onTap,
      Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: ListTile(
        title: Text(name),
        subtitle: Row(
          children: [
            Text('$country | '),
            Text(
              status.name,
              style: TextStyle(
                color: status.name == Status.nice.name
                    ? Colors.greenAccent
                    : Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
