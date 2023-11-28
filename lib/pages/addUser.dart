import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../class/user.dart';
import '../db/db.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();


  @override
  Widget build(BuildContext context) {
    User user;
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("name"),
        TextField(controller: name,),
        Text("lastname"),
        TextField(controller: lastname,),
        Text("age"),
        TextField(controller: age,),
        Text("phone"),
        TextField(controller: phone,),
           Text("id"),
        TextField(controller: id,),
        ElevatedButton(onPressed: () async =>{
          user = User(age: int.parse(age.text), id: int.parse(id.text), lastname: lastname.text, name: name.text, phone: phone.text),
      await DatabaseHelper.insertUser(user),
        Navigator.pushNamed(context, "/")
        }, child: Text("save"))
      ],
    ));
  }
}
