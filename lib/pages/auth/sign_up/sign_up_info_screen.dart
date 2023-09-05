import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';
import 'package:flutix/components/button_component.dart';
import 'package:nb_utils/nb_utils.dart';

class SignUpInfoScreen extends StatefulWidget {
  final VoidCallback voidCallback;
  const SignUpInfoScreen({Key? key, required this.voidCallback}) : super(key: key);

  @override
  State<SignUpInfoScreen> createState() => _SignUpInfoScreenState();
}

class _SignUpInfoScreenState extends State<SignUpInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Stack(
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundColor: constPrimaryColor,
              child: CircleAvatar(
                radius: 70,
                backgroundImage:
                    NetworkImage("https://api.dicebear.com/7.x/lorelei/svg"),
              ),
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: Container(
                child: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Icon(Icons.edit, color: Colors.black),
                ),
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 3,
                      color: constPrimaryColor,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        50,
                      ),
                    ),
                    color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),
        SizedBox(
          height: 60.0,
          child: AppTextField(
            textFieldType: TextFieldType.USERNAME,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'Insert Your Full Name',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Username tidak boleh kosong';
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
            textFieldType: TextFieldType.USERNAME,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Insert Your Email',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Username tidak boleh kosong';
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
            textFieldType: TextFieldType.USERNAME,
            decoration: const InputDecoration(
              labelText: 'Password',
              hintText: 'Make Your Password',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Username tidak boleh kosong';
              }
              return null;
            },
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        AppTextField(
          textFieldType: TextFieldType.PASSWORD,
          decoration: const InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Just to make sure...',
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Password tidak boleh kosong!';
            }
            return null;
          },
        ),
        const SizedBox(
          height: 20.0,
        ),
        ButtonIconComponent(
          buttontext: 'Continue',
          onPressed: widget.voidCallback,
        ),
        const SizedBox(height: 10),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom))
        // ),
      ],
    );
  }
}
