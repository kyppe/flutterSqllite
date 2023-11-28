import 'package:flutter/material.dart';
import 'package:fluttersqllite/pages/addUser.dart';

import 'class/user.dart';
import 'db/db.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/addUser': (context) => AddUserPage(),
        '/': (context) => MyHomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> usersList = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    print("Loading users...");

    await DatabaseHelper.getUsers();
    usersList = await DatabaseHelper.getUsers();

    // List<User> userList = userMaps
    //     .map((userMap) => User(
    //           id: userMap['id'],
    //           name: userMap['name'],
    //           lastname: userMap['lastname'],
    //           age: userMap['age'],
    //           phone: userMap['phone'],
    //         ))
    //     .toList();

    setState(() {
      // users = userList;
    });
  }

  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();
  Future<void> _showMyDialog(int index) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          name.text = usersList[index].name;
          lastname.text = usersList[index].lastname;
          age.text = usersList[index].age.toString();
          phone.text = usersList[index].phone;
          id.text = usersList[index].id.toString();

          User user;
          return AlertDialog(
            content: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text("name"),
                  TextField(
                    controller: name,
                  ),
                  Text("lastname"),
                  TextField(
                    controller: lastname,
                  ),
                  Text("age"),
                  TextField(
                    controller: age,
                  ),
                  Text("phone"),
                  TextField(
                    controller: phone,
                  ),
                  Text("id"),
                  TextField(
                    controller: id,
                  ),
                  ElevatedButton(
                      onPressed: () async => {
                            Navigator.pop(context),
                            user = User(
                                age: int.parse(age.text),
                                id: int.parse(id.text),
                                lastname: lastname.text,
                                name: name.text,
                                phone: phone.text),
                            usersList[index] = user,
                            await DatabaseHelper.updateUser(user),
                            setState(() {})
                          },
                      child: Text("save"))
                ])),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: usersList.length,
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(usersList[index].name),
                Text('Age: ${usersList[index].lastname}'),
                Text('Age: ${usersList[index].age}'),
                Text('phone: ${usersList[index].phone}'),
                InkWell(
                  child: Icon(
                    Icons.edit,
                    color: Colors.amber,
                  ),
                  onTap: () => {_showMyDialog(index)},
                ),
                InkWell(
                  child: Icon(Icons.delete, color: Colors.red),
                  onTap: () => {
                    DatabaseHelper.deleteUser(usersList[index].id),
                    usersList.removeAt(index),
                    setState(() {})
                  },
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {Navigator.pushNamed(context, "/addUser")},
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}
