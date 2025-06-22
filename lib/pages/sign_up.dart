import 'package:befit/main.dart';
import 'package:flutter/material.dart';
import 'package:befit/pages/login_page.dart';
import 'package:befit/pages/app_theme.dart';
import 'package:befit/pages/home_page.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    // Header
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

                    const SizedBox(height: 10),

                    // Sign up/in toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()),
                            );
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppTheme.appBarBg,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Sign in',
                            style:
                            TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    const Text(
                      'Welcome back..!',
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
                              icon: Icons.email_outlined,
                              label: 'Email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 15),
                            _buildInputField(
                              icon: Icons.lock_outline,
                              label: 'Password',
                              controller: passwordController,
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
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  activeColor: AppTheme.primaryColor,
                                  onChanged: (val) {
                                    setState(() {
                                      rememberMe = val!;
                                    });
                                  },
                                ),
                                const Text('Remember password'),
                                const Spacer(),
                                const Text(
                                  'Forgot password?',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  HomeScreen()),
                                  );
                                }
                              },

                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.appBarBg,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('Sign in',
                                  style: TextStyle(fontSize: 18)),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 100),
                    const Text(
                      '────────  Or sign in with  ────────',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 15),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _socialButton('Google', Icons.g_mobiledata),
                        _socialButton('Facebook', Icons.facebook),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Footer Bar
                    // Container(
                    //   height: 100,
                    //   decoration: const BoxDecoration(
                    //     color: AppTheme.primaryColor,
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(60),
                    //       topRight: Radius.circular(60),
                    //     ),
                    //   ),
                    // ),
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
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black),
      validator: (value) =>
      value == null || value.isEmpty ? 'Enter $label' : null,
    );
  }

  Widget _socialButton(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 6),
          Text(label),
        ],
      ),
    );
  }
}
