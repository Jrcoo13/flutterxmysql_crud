import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql_crud/widget/button/custom_button.dart';
import 'package:mysql_crud/widget/textfield.dart';

// ignore: must_be_immutable
class UpdateModal extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final VoidCallback onUpdate;

  const UpdateModal({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        width: 400,
        height: 230,
        child: Column(
          children: [
            CustomTextField(
              hintText: 'Name',
              isObscure: false,
              controller: nameController,
            ),
            CustomTextField(
              hintText: 'Email',
              isObscure: false,
              controller: emailController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    leadingIcon: const Icon(CupertinoIcons.back, color: Colors.white,),
                    label: 'Cancel',
                    onTap: () => Navigator.pop(context),
                  ),
                  CustomButton(
                    leadingIcon: const Icon(CupertinoIcons.plus, color: Colors.white),
                    label: 'Save',
                    onTap: () {
                      onUpdate();
                      Navigator.pop(context); // Close dialog after saving
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
