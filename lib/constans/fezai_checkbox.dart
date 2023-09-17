import 'package:flutter/material.dart';

class fezaiCheckBox extends StatefulWidget {
  final Function(bool value) onChanged;
  final bool value ;
  final double size ;
  final Color clickedColor;
  final Color borderColor;
  final double borderSize;
  var borderRadius ;

  fezaiCheckBox({Key? key,
    required this.value,
    required this.onChanged,
    this.size = 17,
    this.clickedColor = const Color(0xFFF2CB05),
    this.borderColor = Colors.white,
    this.borderSize = 2 ,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<fezaiCheckBox> createState() => _fezaiCheckBoxState();
}

class _fezaiCheckBoxState extends State<fezaiCheckBox> {

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        height: widget.size,
        width: widget.size,
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
          color: widget.value ?  widget.clickedColor : Colors.transparent,
          border: Border.all(
            color: widget.borderColor,
            width: widget.borderSize,
            strokeAlign: 1
          ),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
        ),
        child: Icon(
          Icons.check,
          size: widget.size - 2,
          color: widget.value ? Colors.white :Colors.transparent,
        ),
      ),
    );;
  }
}
