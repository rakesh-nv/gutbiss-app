import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class settings extends StatefulWidget {
  const settings({super.key});

  @override
  State<settings> createState() => _settingsState();
}

class _settingsState extends State<settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('all components'),
      ),
      body: Column(
        children: [
          // Getx Dilog Box
          Card(
            child: ListTile(
              title: const Text("Theme"),
              subtitle: const Text('This is a Getx Dialog Box'),
              onTap: () {
                Get.defaultDialog(
                  title: 'Theme',
                  content: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.light_mode),
                        title: const Text('Light Theme'),
                        onTap: () {
                          Get.changeTheme(ThemeData.light());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.dark_mode),
                        title: const Text('Dark Theme'),
                        onTap: () {
                          Get.changeTheme(
                            ThemeData.dark(),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Getx bottom Sheet
          Card(
            child: ListTile(
              title: const Text("bottom sheet "),
              subtitle: const Text('This is a Getx bottom sheet'),
              onTap: () {
                Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      children: [

                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
