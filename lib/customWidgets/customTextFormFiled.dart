import 'package:flutter/material.dart';
class CustomTextFormField extends StatefulWidget {
  final int maxLength;
  final ValueChanged<String>? onChanged;
  TextEditingController myController;

  CustomTextFormField(
      {required this.maxLength, this.onChanged, required this.myController});

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}
 
 
class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    int remainingCharacters =
        (widget.maxLength - widget.myController.text.length);

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Color(0xff3a3b3d),
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  maxLines: (widget.maxLength / 70).toInt(),
                  controller: widget.myController,
                  onChanged: (text) {
                    if (widget.onChanged != null) {
                      widget.onChanged!(text);
                    }
                    setState(() {
                      // No need to calculate text width in this version.
                    });
                  },
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining: $remainingCharacters/${widget.maxLength}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Maximum Lenght: ${widget.myController.text.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.myController.dispose();
    super.dispose();
  }
}
