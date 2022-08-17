import 'package:flutter/material.dart';

class FakeSearchBar extends StatefulWidget {
  @override
  State<FakeSearchBar> createState() => FakeSearchBarState();
}

class FakeSearchBarState extends State<FakeSearchBar> {
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(),
      ),
      width: 300,
      child: TextField(
        controller: _textController,
        autocorrect: false,
        onChanged: (text) {},
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.search),
          // suffixIcon: GestureDetector(
          //   // onTap: _onClearTapped,
          //   child: const Icon(Icons.clear),
          // ),
          border: InputBorder.none,
          hintText: 'Enter a search term',
        ),
      ),
    );
  }
}
