import 'package:befit/pages/Wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/app_theme.dart';
import 'SignUp_screen.dart';
import 'forgot.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isPasswordVisible = false;
  bool isloading = false;

  Future<void> signIn() async {
    setState(() => isloading = true);
    try {
      UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      final uid = credential.user!.uid;

      DocumentSnapshot userDoc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        final data = userDoc.data() as Map<String, dynamic>;
        print("Name: \${data['name']}");
        print("Email: \${data['email']}");
        print("Photo: \${data['photoUrl']}");
      } else {
        print("⚠️ No user data found in Firestore");
      }

      Get.offAll(() => Wrapper());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Invalid Credentials", e.message ?? "Something went wrong");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }

    setState(() => isloading = false);
  }

  Future<void> signInWithGoogle() async {
    setState(() => isloading = true);
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        setState(() => isloading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final uid = userCredential.user!.uid;
      final userDoc = FirebaseFirestore.instance.collection('users').doc(uid);
      final snapshot = await userDoc.get();

      if (!snapshot.exists) {
        await userDoc.set({
          'name': userCredential.user?.displayName ?? '',
          'email': userCredential.user?.email ?? '',
          'photoUrl': userCredential.user?.photoURL ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      Get.offAll(() => Wrapper());
    } catch (e) {
      Get.snackbar("Google Sign-In Error", e.toString());
    }
    setState(() => isloading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? const Center(child: CircularProgressIndicator())
        : Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.appBarBg, AppTheme.backgroundColor, AppTheme.appBarBg],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                              color: Colors.transparent,
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
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome back..!',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
                                    color: Colors.white,
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
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Forgot())),
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.redAccent,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signIn();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.appBarBg,
                                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text('Login', style: TextStyle(fontSize: 18)),
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
                                label: const Text('Sign in with Google'),
                                onPressed: signInWithGoogle,
                              ),
                              const SizedBox(height: 15),
                              GestureDetector(
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Don’t have an account? ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    Text(
                                      'Sign up',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.blueAccent,
                                        decoration: TextDecoration.underline,
                                        decorationColor: Colors.blueAccent,
                                      ),
                                    ),
                                  ],
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
      cursorColor: Colors.white,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: suffixIcon,
        hintText: 'Enter $label',
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: Colors.white30,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.white),
      validator: validator ?? (value) => value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }
}
