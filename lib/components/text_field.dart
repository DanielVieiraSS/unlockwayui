import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unlockway/constants.dart';

class GenericTextField extends StatelessWidget {
  const GenericTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.width,
    required this.controller,
    required this.number,
  });

  final String title;
  final String placeholder;
  final double width;
  final TextEditingController controller;
  final bool number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          number
              ? RegExp(r'^\d+\.?\d{0,2}')
              : RegExp(
                  r'^.*$',
                  unicode: true,
                ),
        ),
      ],
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.outline,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(darkBgdark)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(primarydark)),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: placeholder,
        label: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontFamily: "Inter",
          ),
        ),
        hintStyle: const TextStyle(color: Color(0xFF616B7C)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        focusColor: Theme.of(context).colorScheme.onSurface,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

class SearchTextField extends StatefulWidget {
  const SearchTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.width,
    required this.controller,
    required this.number,
    required this.method,
  });

  final String title;
  final String placeholder;
  final double width;
  final TextEditingController controller;
  final bool number;
  final Function method;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 500), () {
          widget.method();
        });
      },
      keyboardType: widget.number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          widget.number
              ? RegExp(r'^\d+\.?\d{0,2}')
              : RegExp(
                  r'^.*$',
                  unicode: true,
                ),
        ),
      ],
      controller: widget.controller,
      cursorColor: Theme.of(context).colorScheme.outline,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(darkBgdark)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(primarydark)),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: widget.placeholder,
        label: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontFamily: "Inter",
          ),
        ),
        hintStyle: const TextStyle(color: Color(0xFF616B7C)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        focusColor: Theme.of(context).colorScheme.onSurface,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({
    super.key,
    required this.title,
    required this.placeholder,
    required this.width,
    required this.controller,
    required this.number,
  });

  final String title;
  final String placeholder;
  final double width;
  final TextEditingController controller;
  final bool number;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: true,
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
          number
              ? RegExp(r'^\d+\.?\d{0,2}')
              : RegExp(
                  r'^.*$',
                  unicode: true,
                ),
        ),
      ],
      controller: controller,
      cursorColor: Theme.of(context).colorScheme.outline,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(darkBgdark)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(primarydark)),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: placeholder,
        label: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontFamily: "Inter",
          ),
        ),
        hintStyle: const TextStyle(color: Color(0xFF616B7C)),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        focusColor: Theme.of(context).colorScheme.onSurface,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}

class TextFieldMultline extends StatelessWidget {
  const TextFieldMultline({
    super.key,
    required this.title,
    required this.placeholder,
    required this.width,
    required this.controller,
  });

  final String title;
  final String placeholder;
  final double width;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 3,
      maxLines: 10,
      cursorColor: Theme.of(context).colorScheme.outline,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(darkBgdark)),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(primarydark)),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: placeholder,
        label: Text(
          title,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontFamily: "Inter",
          ),
        ),
        hintStyle: const TextStyle(
          color: Color(0xFF616B7C),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurface,
        focusColor: Theme.of(context).colorScheme.onSurface,
      ),
      style: TextStyle(
        fontFamily: "Inter",
        color: Theme.of(context).colorScheme.outline,
      ),
    );
  }
}
