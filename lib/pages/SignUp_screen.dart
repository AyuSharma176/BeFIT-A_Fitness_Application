import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/app_theme.dart';
import 'Wrapper.dart';
import 'Login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();
  String gender = "Male";
  bool isPasswordVisible = false;
  bool isloading = false;

  signup() async {
    setState(() => isloading = true);

    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': name.text.trim(),
        'email': email.text.trim(),
        'gender': gender,
        'photoUrl': null,
      });

      Get.offAll(() => Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Failed", e.message ?? "Something went wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    setState(() => isloading = false);
  }

  Future<void> signUpWithGoogle() async {
    setState(() => isloading = true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isloading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      await FirebaseFirestore.instance.collection('users').doc(user!.uid).set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'photoUrl': user.photoURL ?? '',
        'gender': gender,
      });

      Get.offAll(() => Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Google Sign-In Failed", e.message ?? "Something went wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    setState(() => isloading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'вє ƒιт',
                                style: TextStyle(
                                  fontSize: 50,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Create An Account',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Itim',
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            _buildInputField(
                              icon: Icons.person_outline,
                              label: 'Full Name',
                              controller: name,
                            ),
                            const SizedBox(height: 15),
                            _buildInputField(
                              icon: Icons.email_outlined,
                              label: 'Email',
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 15),
                            _buildInputField(
                              icon: Icons.lock_outline,
                              label: 'Password',
                              controller: password,
                              obscureText: !isPasswordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Password';
                                } else if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Gender:", style: TextStyle(fontWeight: FontWeight.w500)),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Male'),
                                    value: 'Male',
                                    groupValue: gender,
                                    onChanged: (val) => setState(() => gender = val!),
                                  ),
                                ),
                                Expanded(
                                  child: RadioListTile(
                                    title: const Text('Female'),
                                    value: 'Female',
                                    groupValue: gender,
                                    onChanged: (val) => setState(() => gender = val!),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  signup();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.appBarBg,
                                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('Continue', style: TextStyle(fontSize: 18)),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  side: const BorderSide(color: Colors.black26),
                                ),
                              ),
                              icon: Image.asset(
                                'assets/images/img.png',
                                height: 24,
                                width: 24,
                              ),
                              label: const Text('Sign up with Google'),
                              onPressed: signUpWithGoogle,
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(

                              onTap: () {
                                Get.to(() => const SignInScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Already have an account? ',
                                    style: TextStyle(
                                      // decoration: TextDecoration.underline,
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  const Text(
                                    'Login',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.blueAccent,
                                      fontSize: 15,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                ],

                              onTap: () => Get.to(() => const SignInScreen()),
                              child: const Text(
                                'Already have an account? SignIN',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: suffixIcon,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black54),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
