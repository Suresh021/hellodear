import 'package:flutter/material.dart'; 
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'home_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'welcome',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required String title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _userFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = true;
  bool  _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'LOGIN',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        centerTitle: true,
      ),
      

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
             Icon(
          Icons.person,
          color: Colors.lightBlue,
          size: 100.0,
        ),
             Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
               child: Padding(
               padding: const EdgeInsets.all(16.0),
               child: TextField(
                 controller: _emailController,
                focusNode: _userFocus,
                decoration: InputDecoration(
                  hintText: "Email",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
             ),
             ),
            //const SizedBox(height: 2.0), 
             Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
            child:Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _passwordController,
                 obscureText: _obscurePassword,
                focusNode: _passwordFocus,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  suffixIcon: IconButton(
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
      icon: Icon(
        _obscurePassword ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey,
      ),
    ),
                ),
              ),
            ),
              ),
             ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  _login();
                  // Add login logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
                ),
                child: Text('Login'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.blue),
                
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(_userFocus);
        },
        backgroundColor: const Color.fromARGB(255, 85, 194, 245),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
Future<void> _login() async {
  try {
    final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final User? user = userCredential.user;
    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User logged in successfully'),
          duration: Duration(seconds: 3), // Set the duration as needed
        ),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MyHomePages(title: 'Todofy'),
        ),
      );
    } else {
       print('an error occurred');
    }
  }on FirebaseAuthException catch (e) {
    print('Firebase Authentication Error: ${e.message}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login credentials are invalid'),
        duration: Duration(seconds: 3),
      ),
    );
  } catch (e) {
    print('Error: $e');
   }
}



  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _userFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
}




class SignupScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _signupEmailController = TextEditingController();
  final TextEditingController _signupPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

    final _formKey = GlobalKey<FormState>();

  
 SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'SIGNUP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                 controller: _usernameController,
                focusNode: _nameFocus,
                decoration: InputDecoration(
                  hintText: "Username",
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
                 validator:  (value){
                   if (value == null || value.length < 3 ||  RegExp(r'[!@#%^&*(),.?":{}|<>]').hasMatch(value)) {
                   return 'Username must have at least 3 characters and  must not contain special characters';
                     }
                    return null;
                 }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _signupEmailController,
                focusNode: _emailFocus,
                decoration: InputDecoration(
                  hintText: "Email",
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
                validator: (value){
                   if (value == null || !value.endsWith('@gmail.com')) {
                   return 'Invalid email. Please use a Gmail account.';
                   }
                 return null;
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _signupPasswordController,
                  obscureText: true,
                focusNode: _passwordFocus,
                decoration: InputDecoration(
                  hintText: "Password",
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
                validator: (value){
                  if (value == null || value.length < 6 || !RegExp(r'(?=.*\d)(?=.*[A-Z])(?=.*[a-z])(?=.*[\W_])').hasMatch(value)) {
                  return 'Invalid password.please enter a valid password';
                  }
                  return null; 
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ElevatedButton(
                onPressed: () {
                   if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
                 //_signup();
              );
                  _signup();
                   }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 25, fontStyle: FontStyle.normal),
                ),
                child: Text('Signup'),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Login',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FocusScope.of(context).requestFocus(_nameFocus);
        },
        backgroundColor: const Color.fromARGB(255, 85, 194, 245),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
Future<void> _signup() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _signupEmailController.text.trim(),
        password: _signupPasswordController.text.trim(),
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Signup successful, navigate to the next screen or perform other actions
        print('Signup successful: ${user.email}');
        _usernameController.clear();
        _signupEmailController.clear();
        _signupPasswordController.clear();
      } else {
        // Handle the case where user is null
        print('Signup error.');
      }
    } catch (e) {
      // Handle authentication errors
      print('Error: $e');
    }
  }

  void dispose() {
    _signupEmailController.dispose();
    _signupPasswordController.dispose();
    //super.dispose();
  }
}
