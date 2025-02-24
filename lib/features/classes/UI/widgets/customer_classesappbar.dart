import 'package:flutter/material.dart';

class CustomClassesAppBar extends StatelessWidget {
  final Function(String) onMenuSelected;
  final Enum selectedTab;

  const CustomClassesAppBar({super.key, required this.onMenuSelected, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Programs"),
      actions: [
        PopupMenuButton<String>(
          onSelected: onMenuSelected,
          itemBuilder: (context) => [
            PopupMenuItem(value: "myClasses", child: Text("My Classes")),
            PopupMenuItem(value: "available", child: Text("Available")),
            PopupMenuItem(value: "allPrograms", child: Text("All Programs")),
          ],
        ),
      ],
    );
  }
}
