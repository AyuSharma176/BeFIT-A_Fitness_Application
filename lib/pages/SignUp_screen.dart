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
  bool isPasswordVisible = false;
  bool isloading = false;

  signup() async {
    setState(() {
      isloading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      Get.offAll(() => Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Signup Failed", e.message ?? "Something went wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    setState(() {
      isloading = false;
    });
  }

  Future<void> signUpWithGoogle() async {
    setState(() => isloading = true);

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() => isloading = false);
        return; // User canceled
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // ✅ Optional: Save user data in Firestore
      // await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
      //   'name': userCredential.user!.displayName,
      //   'email': userCredential.user!.email,
      //   'photoUrl': userCredential.user!.photoURL,
      // });

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
                                  isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
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
                              child: const Text('Sign Up', style: TextStyle(fontSize: 18)),
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
                                'assets/images/img.png', // Ensure this asset exists
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
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.black),
        suffixIcon: suffixIcon,
        labelText: '$label :',
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
