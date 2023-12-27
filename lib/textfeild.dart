import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'TODO'),
    );
  }
}

class Task {
  final String title;
  final String description;

  Task({required this.title, required this.description});
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String enteredTitle = ''; 
  String enteredDescription = ''; 
  final FocusNode _titleFocus = FocusNode(); 
  final FocusNode _descriptionFocus = FocusNode(); 
  List<Task> tasks = []; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Colors.blue,  
        title: Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                focusNode: _titleFocus,
                onChanged: (value) {
                  setState(() {
                    enteredTitle = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                focusNode: _descriptionFocus,
                onChanged: (value) {
                  setState(() {
                    enteredDescription = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
           child:ElevatedButton(
              onPressed: () {
                if (enteredTitle.isNotEmpty && enteredDescription.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(title: enteredTitle, description: enteredDescription));
                    enteredTitle = '';
                    enteredDescription = ''; 
                    _titleFocus.unfocus(); 
                    _descriptionFocus.unfocus(); 
                  });
                }
              },
              style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
               textStyle: const TextStyle(
                 fontSize: 25, 
                 fontStyle: FontStyle.normal
                 ),
              ),
              child: const Text('Add Task'),
            
           ),
            ),
            for (Task task in tasks)
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      ' ${task.title}',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      ' ${task.description}',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is my task',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      'This is my task description',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
               Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Color.fromARGB(255, 83, 249, 94),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is my task',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      'This is my task description',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
               Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is my task',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      'This is my task description',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
               Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color: Color.fromARGB(255, 83, 249, 94),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is my task',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      'This is my task description',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                color:Color.fromARGB(255, 255, 255, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'This is my task',
                      style: const TextStyle(fontSize: 25),
                    ),
                    Text(
                      'This is my task description',
                      style: const TextStyle(fontSize: 20, color: Colors.grey),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(_titleFocus);
        },
        backgroundColor: const Color.fromARGB(255, 85, 194, 245),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _descriptionFocus.dispose();
    super.dispose();
  }
}