import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_example/models/info_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<List<Info>> getData() async {
    final data = await rootBundle.loadString("assets/data.json");
    final info = jsonDecode(data) as List;
    return List.generate(info.length, (index) => Info.fromMap(info[index]));
  }

  Future getName() async {
    final data = await rootBundle.loadString("assets/data.json");
    String name = jsonDecode(data)[1]["name"];
    debugPrint(name);
  }

  @override
  Widget build(BuildContext context) {
    getName();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json data"),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: getData(),
              builder: (_, snap) {
                if (snap.hasError) {
                  return Center(
                    child: Text(snap.error.toString()),
                  );
                }
                if (snap.hasData) {
                  final data = snap.data as List<Info>;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (_, i) {
                        final item = data[i];
                        return Card(
                          child: ListTile(
                            title: Text("Name: ${item.name}"),
                            subtitle: Text("Age: ${item.age}"),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}
