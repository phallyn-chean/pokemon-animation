import 'package:flutter/material.dart';
import 'package:pokemon_animation/widgets/modal.dart';
import 'package:pokemon_animation/widgets/search_bar.dart';

class SearchBottomModal extends StatelessWidget {
  const SearchBottomModal({super.key});

  @override
  Widget build(BuildContext context) {
    var viewInsets = MediaQuery.of(context).viewInsets.bottom;
    var safeAreaBottom = MediaQuery.of(context).padding.bottom;
    return Modal(
        child: Flexible(
      child: Padding(
        padding: EdgeInsets.fromLTRB(26, 14, 26, 14 + viewInsets + safeAreaBottom),
        child: const SearchBarWidget(
          margin: EdgeInsets.zero,
        ),
      ),
    ));
  }
}
