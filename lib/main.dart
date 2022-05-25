import 'package:flutter/material.dart';
import 'package:todo_list_app/styles/colors.dart';
import 'package:todo_list_app/styles/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      theme: ThemeData(
        primaryColor: Colors.green,
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 30,
                bottom: 20,
              ),
              child: Text(
                "To Do List",
                style: appBarTitleStyle,
              ),
            ),
            //SizedBox(width: 18),
            // Expanded(
            //   child: Image.asset(
            //     "assets/images/todo_list_logo.png",
            //     fit: BoxFit.scaleDown, //height: size.height * 0.2,
            //   ),
            // ),
          ],
        ),
        backgroundColor: appBarcolor,
        elevation: 0,
      ),
      body: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class Job {
  final String name;
  bool done;

  Job({required this.name, this.done = false});
}

class _TodoListState extends State<TodoList> {
  final myController = TextEditingController();
  final jobList = List<Job>.empty(growable: true);
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void add() {
    setState(() {
      jobList.add(Job(name: myController.text));
    });
    myController.clear();
  }

  void remove(Job job) {
    setState(() {
      jobList.remove(job);
    });
  }

  void done(Job job) {
    setState(() {
      job.done = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        color: appBarcolor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: TextField(
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Enter new job',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(
              height: 15,
            ),
                TextButton(onPressed: add, child: Text("Add")),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  for (var job in jobList) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          job.name,
                          style: TextStyle(
                              fontSize: 20,
                              decoration: job.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white70,
                              ),
                              onPressed: job.done ? null : () => done(job),
                              child: Text(
                                "Done",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () => remove(job),
                              child: Text(
                                "Remove",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
