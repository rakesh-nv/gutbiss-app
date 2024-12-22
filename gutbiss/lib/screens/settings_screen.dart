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
        title: const Text('Settings'),
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
                  Card(
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: Colors.black),
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 50,right: 50),
                            child: Divider(height: 3, thickness: 3),
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            title: const Text("Theme"),
                            subtitle: const Text('This is a Getx Dialog Box'),
                            onTap: () {},
                          ),
                          const Divider(
                            color: Colors.black12,
                          ),
                          // Getx bottom Sheet
                          ListTile(
                            title: const Text("bottom sheet "),
                            subtitle: const Text('This is a Getx bottom sheet'),
                            onTap: () {},
                          ),
                        ],
                      ),
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
