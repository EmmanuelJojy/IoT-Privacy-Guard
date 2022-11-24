import 'package:flutter/material.dart';
import 'package:my_app/data/shared.dart';
import 'package:my_app/logic/request.dart';
import 'package:my_app/routes/home.dart';

class ActionCard extends StatefulWidget {
  final String text;
  final int? id;
  final bool? isClickable;
  final IconData? icon;
  final String? subTitle;
  const ActionCard(this.text,
      {this.isClickable, this.id, this.icon, this.subTitle, Key? key})
      : super(key: key);

  @override
  State<ActionCard> createState() => _ActionCardState();
}

class _ActionCardState extends State<ActionCard> {
  final controller = TextEditingController();
  bool operationStatus = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isClickable == true && widget.id == 1) {
          refresh(widget.id!);
        }
        if (widget.isClickable == true && widget.id == 2) {
          refresh(widget.id!);
        }
      },
      child: Card(
        color: widget.icon == null ? Colors.grey[350] : null,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        elevation: widget.icon != null ? 4 : 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: widget.icon != null
                ? CircleAvatar(
                    radius: 30,
                    child: Icon(widget.icon),
                  )
                : null,
            title: Text(
              widget.text,
              textAlign: widget.icon == null ? TextAlign.center : null,
            ),
            subtitle: widget.subTitle != null
                ? Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.subTitle!,
                      textAlign: TextAlign.center,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
