import 'package:flutter/material.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            // controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 16.0),
          const TextField(
            // controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle login button press
                },
                child: const Text('Login'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle cancel button press
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
          CheckboxListTile(
            title: const Text('Remember Login'),
            value: false,
            onChanged: (value) {
              // Handle remember login checkbox
            },
          ),
          TextButton(
            onPressed: () {
              // Handle reset password button press
            },
            child: const Text('Reset Password'),
          ),
          const SizedBox(height: 32.0),
          Image.asset(
            'assets/EXCELLENCE.jpg',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 16.0),
          // Text('40 YEARS OF EXCELLENCE'),
        ],
      ),
    );
  }
}
