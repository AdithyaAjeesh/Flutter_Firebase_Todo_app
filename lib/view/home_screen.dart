import 'package:flutter/material.dart';
import 'package:flutter_firebase_todo_app/controller/functions_controller.dart';
import 'package:flutter_firebase_todo_app/model/todo_model.dart';
import 'package:flutter_firebase_todo_app/view/add_screen.dart';
import 'package:flutter_firebase_todo_app/view/update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FunctionsController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Todo App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: StreamBuilder<List<TodoModel>>(
          stream: provider.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TodoModel data = snapshot.data![index];
                  final name = data.name.toString();
                  final subName = data.subName.toString();
                  final isDone = data.isDone;
                  // return ListTile(
                  //   onTap: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute(
                  //         builder: (context) => UpdateScreen(
                  //           isDone: data.isDone == null ? false : data.isDone!,
                  //           docId: data.id.toString(),
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   title: Text(
                  //     name,
                  //     style: const TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   subtitle: Text(data.isDone.toString()),
                  //   trailing: ElevatedButton(
                  //     onPressed: () {
                  //       provider.deleteData(data.id!);
                  //     },
                  //     child: const Text('DELETE'),
                  //   ),

                  // );
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateScreen(
                            docId: data.id.toString(),
                            isDone: data.isDone!,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      height: 80,
                      decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Task: $subName',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  provider.toggleCompleate(
                                    data.id,
                                    isDone,
                                    name,
                                    subName,
                                  );
                                },
                                child: Text(isDone == true
                                    ? 'Compleated'
                                    : 'Not Compleate'),
                              ),
                              IconButton(
                                onPressed: () {
                                  provider.deleteData(data.id);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
