import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PlaylistForm extends StatefulWidget {
  @override
  _PlaylistFormState createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<PlaylistForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameController = TextEditingController();
  File? _image;

  Future<void> _getImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  void dispose() {
    _playlistNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _playlistNameController,
            decoration: InputDecoration(
                labelText: 'Playlist Name', border: OutlineInputBorder()),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a playlist name';
              }
              return null;
            },
          ),
          SizedBox(height: 20.0),
          _image == null
              ? ElevatedButton(
                  onPressed: _getImage,
                  child: Text('Pick an Image'),
                )
              : Image.file(
                  _image!,
                  height: 65,
                  width: 65,
                ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save the playlist name and image here
                String playlistName = _playlistNameController.text;
                // You can use _image for further processing or saving it to storage
                // Example: File(_image!.path).copy('/path/to/save/image.png');

                // Reset the form
                _formKey.currentState!.reset();
                _image = null;

                // Show a success message or perform further actions
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Playlist created: $playlistName')),
                );
              }
            },
            child: Text('Create Playlist'),
          ),
        ],
      ),
    );
  }
}
