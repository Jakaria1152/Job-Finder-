import 'package:flutter/material.dart';

class MessageTextField extends StatelessWidget {
  const MessageTextField({
    super.key,
    required this.messageController,
    required this.suffixIcon,
    this.onChanged,
    this.onEditingComplete, this.onTapOutside, this.onSubmitted,
  });

  final TextEditingController messageController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      alignment: Alignment.bottomCenter,
      child: TextField(
        controller: messageController,
        cursorColor: Colors.grey,
        keyboardType: TextInputType.multiline, // very ueful
        style: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(6),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: suffixIcon,
          hintText: "Type your message here",
          hintStyle: TextStyle(
              fontSize: 14, color: Colors.grey, fontWeight: FontWeight.normal),
          // this border show when click textfield
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
          // this border show without click textfield
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey)),
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onTapOutside: onTapOutside,  // very useful
        onSubmitted: onSubmitted,
      ),
    );
  }
}
