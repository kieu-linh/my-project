import 'package:my_project/base/base_page.dart';
import 'package:my_project/constants/constants.dart';
import 'package:my_project/extensions/app_extensions.dart';
import 'package:my_project/models/book.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/screen/book/book_form_vm.dart';
import 'package:flutter/material.dart';

class BookFormScreen extends StatefulWidget {
  final Book? book;

  const BookFormScreen({Key? key, this.book}) : super(key: key);

  @override
  _BookFormScreenState createState() => _BookFormScreenState();
}

class _BookFormScreenState extends State<BookFormScreen> with BasePage<BookFormVM> {
  @override
  void initState() {
    super.initState();
    if (widget.book != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        provider.initWithBook(widget.book!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(widget.book != null ? context.l10n.editBook : context.l10n.addBook),
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
                  label: context.l10n.title,
                  initialValue: provider.title,
                  onSave: provider.setTitle,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  icon: Icons.book,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: context.l10n.author,
                  initialValue: provider.author,
                  onSave: provider.setAuthor,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  icon: Icons.person,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Category',
                  initialValue: provider.category,
                  onSave: provider.setCategory,
                  validator: (v) => v?.isEmpty ?? true ? 'Required' : null,
                  icon: Icons.category,
                ),
                const SizedBox(height: 16),
                _buildQuantitySelector(),
                const SizedBox(height: 16),
                _buildTextField(
                  label: context.l10n.description,
                  initialValue: provider.description,
                  onSave: provider.setDescription,
                  icon: Icons.description,
                  maxLines: 3,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: provider.saveBook,
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

  Widget _buildQuantitySelector() {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          const Icon(Icons.inventory_2, color: AppColors.primary),
          const SizedBox(width: 16),
          Text(
            'Total Copies',
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            onPressed: provider.totalCopies > 1
                ? () {
                    provider.setTotalCopies(provider.totalCopies - 1);
                  }
                : null,
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.remove, color: AppColors.primary),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              provider.totalCopies.toString(),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              provider.setTotalCopies(provider.totalCopies + 1);
            },
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BookFormVM create() => BookFormVM();

  @override
  void initialise(BuildContext context) {}
}
