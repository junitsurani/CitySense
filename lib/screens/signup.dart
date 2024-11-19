import 'package:flutter/material.dart';
// import 'package:flutter_firebase_project/Login%20Signup/Widget/button.dart';

import '../Services/authentication.dart';
import '../Widget/snackbar.dart';
import '../Widget/text_field.dart';
import 'home_screen.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    mobileController.dispose();
    locationController.dispose();
  }

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });

    // Check if all fields are filled
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        mobileController.text.isEmpty ||
        locationController.text.isEmpty ||
        passwordController.text.isEmpty) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Please fill all the fields");
      return;
    }

    // Validate email
    if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(emailController.text)) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Please enter a valid email address");
      return;
    }

    // Validate mobile number
    if (mobileController.text.length != 10) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, "Please enter a valid 10-digit mobile number");
      return;
    }

    // Signup user using authentication service
    String res = await AuthMethod().signupUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
      location: locationController.text, // Add location
      mobile: mobileController.text,    // Add mobile
    );

    // Navigate to home screen if successful
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // Show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height / 2.8,
                child: Image.asset('images/signup.jpeg'),
              ),
              TextFieldInput(
                icon: Icons.person,
                textEditingController: nameController,
                hintText: 'Enter your name',
                textInputType: TextInputType.text,
              ),
              TextFieldInput(
                icon: Icons.email,
                textEditingController: emailController,
                hintText: 'Enter your email',
                textInputType: TextInputType.emailAddress,
              ),
              TextFieldInput(
                icon: Icons.phone,
                textEditingController: mobileController,
                hintText: 'Enter your mobile number',
                textInputType: TextInputType.phone,
              ),
              TextFieldInput(
                icon: Icons.location_on,
                textEditingController: locationController,
                hintText: 'Enter your location',
                textInputType: TextInputType.text,
              ),
              TextFieldInput(
                icon: Icons.lock,
                textEditingController: passwordController,
                hintText: 'Enter your password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              MyButtons(
                onTap: signupUser,
                text: isLoading ? "Signing Up..." : "Sign Up",
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      " Login",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
