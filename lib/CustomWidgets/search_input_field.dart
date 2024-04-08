import 'package:flutter/material.dart';
import 'package:easy_debounce/easy_debounce.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    Key? key,
    required this.controller,
    this.hint = "",
    this.validator,
    this.onTextChanged,
    this.keyboardType = TextInputType.text,
    required this.isDark,
  }) : super(key: key);

  final String hint;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onTextChanged;
  final TextInputType keyboardType;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: (value) {
        EasyDebounce.debounce(
          'inputFieldDebounceKey',
          const Duration(milliseconds: 1000),
          () {
            FocusScope.of(context).unfocus();
            onTextChanged?.call(value);
          },
        );
      },
      decoration: InputDecoration(
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  onTextChanged?.call("");
                },
                icon: const Icon(Icons.cancel_outlined),
              )
            : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
