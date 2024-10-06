import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql_crud/widget/modal/update_modal.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userData = [];

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();

  Future<void> updateData(String id, String name, String email) async {
    try {
      String uri = "http://127.0.0.1/flutter_crud_api/update.php";

      var response = await http.post(Uri.parse(uri), body: {
        "id": id,
        "name": name,
        "email": email,
      });

      var result = jsonDecode(response.body);

      if (result['success'] == true) {
        print('Successfully updated');
        setState(() {
          getData();
        });
      } else {
        print('Updating user failed: ${result['message']}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void viewModal(String id, String name, String email) {
    nameTextController.text = name;
    emailTextController.text = email;

    showDialog(
      context: context,
      builder: (context) {
        return UpdateModal(
          nameController: nameTextController,
          emailController: emailTextController,
          onUpdate: () {
            updateData(id, nameTextController.text, emailTextController.text);
          },
        );
      },
    );
  }

  Future<void> getData() async {
    try {
      String uri = "http://127.0.0.1/flutter_crud_api/view.php";

      var response = await http.get(Uri.parse(uri));

      setState(() {
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteData(String id) async {
    try {
      String uri = "http://127.0.0.1/flutter_crud_api/delete.php";

      var result = await http.post(Uri.parse(uri), body: {"id": id});

      var response = jsonDecode(result.body);

      if (response["success"] != "true") {
        print("The id {$id} successfully deleted");

        setState(() {
          getData();
        });
      } else {
        print("delete user failed");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Insert Record',
            style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w400)),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: userData.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => {
                viewModal(userData[index]['id'].toString(),
                    userData[index]['name'], userData[index]['email'])
              },
              child: Card(
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(CupertinoIcons.person, size: 25,),
                  title: Text(userData[index]['id'].toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userData[index]['name']),
                      Text(userData[index]['email']),
                      Text(userData[index]['join_date'])
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.delete),
                    onPressed: () => {
                      deleteData(userData[index]['id'].toString()),
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
