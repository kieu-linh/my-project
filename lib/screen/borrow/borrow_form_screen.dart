import 'package:my_project/base/base_page.dart';
import 'package:my_project/constants/constants.dart';
import 'package:my_project/extensions/app_extensions.dart';
import 'package:my_project/models/book.dart';
import 'package:my_project/screen/borrow/borrow_form_vm.dart';
import 'package:flutter/material.dart';

class BorrowFormScreen extends StatefulWidget {
  const BorrowFormScreen({Key? key}) : super(key: key);

  @override
  _BorrowFormScreenState createState() => _BorrowFormScreenState();
}

class _BorrowFormScreenState extends State<BorrowFormScreen> with BasePage<BorrowFormVM> {
  @override
  void initState() {
    super.initState();
    provider.init();
  }

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(context.l10n.borrowBook),
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBookSelector(),
              const SizedBox(height: 16),
              _buildDurationSelector(),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: provider.borrowBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  context.l10n.borrowBook,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.selectBook,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...provider.availableBooks.map((book) => _buildBookOption(book)),
        ],
      ),
    );
  }

  Widget _buildBookOption(Book book) {
    final isSelected = provider.selectedBook?.id == book.id;
    final isAvailable = book.availableCopies > 0;

    return GestureDetector(
      onTap: isAvailable ? () => provider.setSelectedBook(book) : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.primaryLight,
              ),
              child: book.coverUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        book.coverUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.menu_book,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : const Icon(Icons.menu_book, color: AppColors.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isAvailable ? null : AppColors.grey,
                    ),
                  ),
                  Text(
                    book.author,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (isAvailable ? AppColors.success : AppColors.error).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${book.availableCopies}',
                style: TextStyle(
                  color: isAvailable ? AppColors.success : AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
          const Icon(Icons.calendar_today, color: AppColors.primary),
          const SizedBox(width: 16),
          Text(
            context.l10n.duration,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const Spacer(),
          IconButton(
            onPressed: provider.durationDays > 1
                ? () => provider.setDuration(provider.durationDays - 1)
                : null,
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.remove, color: AppColors.primary, size: 20),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${provider.durationDays} ${context.l10n.days}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          IconButton(
            onPressed: () => provider.setDuration(provider.durationDays + 1),
            icon: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.add, color: AppColors.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  @override
  BorrowFormVM create() => BorrowFormVM();

  @override
  void initialise(BuildContext context) {}
}
