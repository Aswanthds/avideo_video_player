import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String hint;

  const SearchWidget({
    super.key,
    TextEditingController? controller,
    required this.hint,
  }) : _controller = controller;

  final TextEditingController? _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Center(
          child: ListTile(
            title: TextField(
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                color: Colors.black,
              ),
              controller: _controller,
            ),
          ),
        ),
      ),
    );
  }
}
