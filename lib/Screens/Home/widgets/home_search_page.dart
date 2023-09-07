import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:video_player_app/constants.dart';
import 'package:video_player_app/widgets/search_widget.dart';

class HomeSearchPaage extends StatefulWidget {
  final List<File>? files;
  final String text;
  const HomeSearchPaage({Key? key, this.files, required this.text}) : super(key: key);

  @override
  State<HomeSearchPaage> createState() => _HomeSearchPaageState();
}

class _HomeSearchPaageState extends State<HomeSearchPaage> {
  final TextEditingController _controller = TextEditingController();
  ValueNotifier<String> _textNotifier = ValueNotifier('');
  List<String> filteredFiles = [];

  Widget _buildResults() {
    return ListView.builder(
      itemCount: filteredFiles.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(basename(filteredFiles[index])),
        );
      },
    );
  }

  void _updateFilteredFiles() {
    final List<String> inputWords =
        _textNotifier.value.toLowerCase().split(' ');

    filteredFiles = widget.files
            ?.where((file) {
              final fileName = basename(file.path).toLowerCase();
              return inputWords.every((word) => fileName.contains(word));
            })
            .map((file) => file.path)
            .toList() ??
        [];

    _textNotifier.value = _textNotifier.value;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _textNotifier.value = _controller.text;
      _updateFilteredFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back)),
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
          ),
          child: SearchWidget(
            controller: _controller,
            hint: widget.text,
          ),
        ),
      ),
      body: SafeArea(
        child: _buildResults(),
      ),
    );
  }
}
