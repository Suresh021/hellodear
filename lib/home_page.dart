import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(Homepage());
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePages(title: 'Todofy'),
    );
  }
}

class MyHomePages extends StatefulWidget {
  MyHomePages({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePages> {
    final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  
   void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: 600,
        color: Color.fromARGB(255, 0, 0, 0),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Task',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:Color.fromARGB(255, 255, 255, 255),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _titleController,
               style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Title', 
                labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                border: OutlineInputBorder(
                   borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
               style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Description',
                 labelStyle: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                border: OutlineInputBorder(
                   borderSide: BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: ()  async {
               CollectionReference collref = FirebaseFirestore.instance.collection('tasks');
                DocumentReference docRef = await collref.add({
                'title': _titleController.text,
                'description':_descriptionController.text,
                'time': Timestamp.now(),
                'status': 'todo', 
               });
               print('Document added with ID: ${docRef.id}');
                Navigator.pop(context); 
              },
              child: Text('Save',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:Color.fromARGB(255, 0, 0, 0),
              ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'To Do',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
           SizedBox(height: 16),
           
           
           
       StreamBuilder(
  stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final tasks = snapshot.data?.docs.map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id}).toList();
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      tasks?.sort((a, b) {
        final timestampA =
            (a['time'] as Timestamp?)?.millisecondsSinceEpoch ?? currentTime;
        final timestampB =
            (b['time'] as Timestamp?)?.millisecondsSinceEpoch ?? currentTime;
        return (timestampB).compareTo(timestampA);
      });

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tasks!.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          bool completed = task['status'] == 'completed';
          String documentId = snapshot.data!.docs[index].id;


           if (!completed) {
          final Timestamp? timestamp = task['time'] as Timestamp?;
          final DateTime? dateTime = timestamp?.toDate();
          final formattedDate = dateTime != null
              ? "${dateTime.hour}:${dateTime.minute}:${dateTime.second}"
              : 'No time';

          
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: completed
                      ? Color.fromARGB(255, 111, 208, 63)
                      : Color.fromARGB(255, 241, 115, 115),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task['title'],
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          task['description'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          'Timestamp: $formattedDate',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: completed,
                      onChanged: (value) {
                        setState(() {
                          // Toggle the 'status' field in Firestore
                          String newStatus = value! ? 'completed' : 'todo';
                          FirebaseFirestore.instance.collection('tasks').doc(documentId).update({'status': newStatus});
                        });
                      },
                      shape: CircleBorder(),
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          );
          } else {
                  return Container(); 
                 }
        },
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return CircularProgressIndicator();
    }
  },
),
  


            SizedBox(height: 50),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Completed',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
             StreamBuilder(
  stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final tasks = snapshot.data?.docs.map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id}).toList();
      final currentTime = DateTime.now().millisecondsSinceEpoch;

      tasks?.sort((a, b) {
        final timestampA =
            (a['time'] as Timestamp?)?.millisecondsSinceEpoch ?? currentTime;
        final timestampB =
            (b['time'] as Timestamp?)?.millisecondsSinceEpoch ?? currentTime;
        return (timestampB).compareTo(timestampA);
      });

      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: tasks!.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          bool completed = task['status'] == 'completed';
          String documentId = snapshot.data!.docs[index].id;


           if (completed) {
          final Timestamp? timestamp = task['time'] as Timestamp?;
          final DateTime? dateTime = timestamp?.toDate();
          final formattedDate = dateTime != null
              ? "${dateTime.hour}:${dateTime.minute}:${dateTime.second}"
              : 'No time';

          
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: completed
                      ? Color.fromARGB(255, 111, 208, 63)
                      : Color.fromARGB(255, 241, 115, 115),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          task['title'],
                          style: const TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          task['description'],
                          style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                        Text(
                          'Timestamp: $formattedDate',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ],
                    ),
                    Checkbox(
                      value: completed,
                      onChanged: (value) {
                        setState(() {
                          // Toggle the 'status' field in Firestore
                          String newStatus = value! ? 'completed' : 'todo';
                          FirebaseFirestore.instance.collection('tasks').doc(documentId).update({'status': newStatus});
                        });
                      },
                      shape: CircleBorder(),
                      activeColor: Colors.black,
                      checkColor: Colors.white,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          );
          } else {
                  return Container(); 
                 }
        },
      );
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return CircularProgressIndicator();
    }
  },
),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showBottomSheet();
        },
         backgroundColor: Color.fromARGB(255, 0, 0, 0),
        shape: const CircleBorder(),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}