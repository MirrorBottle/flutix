import 'package:flutix/providers/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/components/button_component.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SignUpInfoScreen extends StatefulWidget {
  final VoidCallback voidCallback;
  const SignUpInfoScreen({Key? key, required this.voidCallback})
      : super(key: key);

  @override
  State<SignUpInfoScreen> createState() => _SignUpInfoScreenState();
}

class _SignUpInfoScreenState extends State<SignUpInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpProvider>(builder: (context, signUpData, child) {
      return Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 60.0,
            child: AppTextField(
              controller: _nameController,
              textFieldType: TextFieldType.USERNAME,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Insert Your Full Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Full name tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 60.0,
            child: AppTextField(
              controller: _emailController,
              textFieldType: TextFieldType.EMAIL,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Insert Your Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            height: 60.0,
            child: AppTextField(
              controller: _passwordController,
              textFieldType: TextFieldType.PASSWORD,
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Make Your Password',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ButtonIconComponent(
            buttontext: 'Continue',
            onPressed: () {
              Provider.of<SignUpProvider>(context, listen: false)
                  .changeInfoData(
                      email: _emailController.text,
                      name: _nameController.text,
                      password: _passwordController.text);
              widget.voidCallback();
            },
          ),
          const SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom))
          // ),
        ],
      );
    });
  }
}
