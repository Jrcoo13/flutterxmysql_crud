import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_crud/pages/view_page.dart';
import 'package:mysql_crud/widget/textfield.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  FocusNode focusNode = FocusNode();

  //insert data
  Future<void> insertData() async {
    if (_nameTextController.text != "" ||
        _emailTextController.text != "" ||
        _passwordTextController.text != "") {
      try {
        String uri = "http://127.0.0.1/flutter_crud_api/insert.php";

        var res = await http.post(Uri.parse(uri), body: {
          "name": _nameTextController.text,
          "email": _emailTextController.text,
          "password": _passwordTextController.text
        });

        var response = jsonDecode(res.body);
        if (response["success"] != "true") {
          print('Record Inserted Successfully');
          _nameTextController.text = '';
          _emailTextController.text = '';
          _passwordTextController.text = '';
        } else {
          print('Inserting Record Failed');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('please fill all the fields');
    }
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                icon: const Icon(CupertinoIcons.person_2_fill),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ViewData()))),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomTextField(
                  hintText: 'Name',
                  isObscure: false,
                  controller: _nameTextController,
                ),
                CustomTextField(
                  hintText: 'Email',
                  isObscure: false,
                  controller: _emailTextController,
                ),
                CustomTextField(
                  hintText: 'Password',
                  isObscure: true,
                  controller: _passwordTextController,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //insert button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(
              onTap: () {
                _nameTextController.text.isEmpty && _emailTextController.text.isEmpty && _passwordTextController.text.isEmpty ?
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.red.shade500,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Sub Title',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ) :
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    content: Container(
                      padding: const EdgeInsets.all(16),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.green.shade500,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Title',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Sub Title',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                );
                insertData();
                
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.blue.shade500,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
