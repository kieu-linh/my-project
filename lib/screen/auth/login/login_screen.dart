import 'package:my_project/base/base_page.dart';
import 'package:my_project/constants/constants.dart';
import 'package:my_project/extensions/app_extensions.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/screen/auth/login/login_vm.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String? email;
  const LoginScreen({Key? key, this.email}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with BasePage<LoginVM> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email ?? '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildLoginCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: const Icon(
            Icons.menu_book,
            size: 60,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Library App',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.l10n.login,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Form(
        key: provider.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              context.l10n.email,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _emailController,
              icon: Icons.email_outlined,
              hint: context.l10n.pleaseEnterEmail,
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v?.isEmpty ?? true) return context.l10n.pleaseEnterEmail;
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v!)) {
                  return context.l10n.invalidEmail;
                }
                return null;
              },
              onSaved: (v) => provider.email = v,
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.password,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 8),
            _buildTextField(
              controller: _passwordController,
              icon: Icons.lock_outlined,
              hint: context.l10n.pleaseEnterPassword,
              obscure: provider.obscureText,
              suffixIcon: IconButton(
                icon: Icon(
                  provider.obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: provider.visiblePassword,
              ),
              validator: (v) {
                if (v?.isEmpty ?? true) return context.l10n.pleaseEnterPassword;
                if (v!.length < 6) return context.l10n.passwordMinLength;
                return null;
              },
              onSaved: (v) => provider.password = v,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: provider.login,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                context.l10n.login,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.l10n.clickHereTo,
                  style: const TextStyle(color: AppColors.grey),
                ),
                TextButton(
                  onPressed: () => AppRouter.goSignup(context),
                  child: Text(
                    context.l10n.registration,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    bool obscure = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.grey),
        prefixIcon: Icon(icon, color: AppColors.primary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.greyLight.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }

  @override
  LoginVM create() => LoginVM();

  @override
  void initialise(BuildContext context) {
    provider.setContext(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
