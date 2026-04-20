import 'package:my_project/base/base_page.dart';
import 'package:my_project/constants/constants.dart';
import 'package:my_project/extensions/app_extensions.dart';
import 'package:my_project/models/member.dart';
import 'package:my_project/screen/member/member_form_vm.dart';
import 'package:flutter/material.dart';

class MemberFormScreen extends StatefulWidget {
  final Member? member;

  const MemberFormScreen({Key? key, this.member}) : super(key: key);

  @override
  _MemberFormScreenState createState() => _MemberFormScreenState();
}

class _MemberFormScreenState extends State<MemberFormScreen> with BasePage<MemberFormVM> {
  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.initWithMember(widget.member!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(widget.member != null ? context.l10n.editMember : context.l10n.addMember),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: provider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  label: context.l10n.name,
                  initialValue: provider.name,
                  onSave: provider.setName,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: context.l10n.email,
                  initialValue: provider.email,
                  onSave: provider.setEmail,
                  validator: (v) {
                    if (v?.isEmpty ?? true) return 'Required';
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v!)) {
                      return 'Invalid email';
                    }
                    return null;
                  },
                  icon: Icons.email,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: context.l10n.phone,
                  initialValue: provider.phone,
                  onSave: provider.setPhone,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: context.l10n.address,
                  initialValue: provider.address,
                  onSave: provider.setAddress,
                  icon: Icons.location_on,
                  maxLines: 2,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: provider.saveMember,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    context.l10n.save,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    String? initialValue,
    required Function(String?) onSave,
    String? Function(String?)? validator,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        initialValue: initialValue,
        onSaved: onSave,
        validator: validator,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  @override
  MemberFormVM create() => MemberFormVM();

  @override
  void initialise(BuildContext context) {}
}
