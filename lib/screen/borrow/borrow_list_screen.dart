import 'package:my_project/base/base_page.dart';
import 'package:my_project/constants/constants.dart';
import 'package:my_project/extensions/app_extensions.dart';
import 'package:my_project/models/borrow_record.dart';
import 'package:my_project/router/app_router.dart';
import 'package:my_project/screen/borrow/borrow_list_vm.dart';
import 'package:flutter/material.dart';

class BorrowListScreen extends StatefulWidget {
  const BorrowListScreen({Key? key}) : super(key: key);

  @override
  _BorrowListScreenState createState() => _BorrowListScreenState();
}

class _BorrowListScreenState extends State<BorrowListScreen> with BasePage<BorrowListVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildFilterChips(),
              Expanded(child: _buildBorrowList()),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => AppRouter.goAddBorrow(context),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            context.l10n.borrowReturn,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildFilterChip(context.l10n.all, 'all'),
          const SizedBox(width: 8),
          _buildFilterChip(context.l10n.borrowed, 'borrowed'),
          const SizedBox(width: 8),
          _buildFilterChip(context.l10n.overdue, 'overdue'),
          const SizedBox(width: 8),
          _buildFilterChip(context.l10n.returned, 'returned'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = provider.filterStatus == value;
    return GestureDetector(
      onTap: () => provider.setFilter(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyLight,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColors.greyDark,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildBorrowList() {
    if (provider.filteredBorrows.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 64, color: AppColors.grey),
            const SizedBox(height: 16),
            Text(
              context.l10n.noData,
              style: TextStyle(color: AppColors.grey),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async => provider.refresh(),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.filteredBorrows.length,
        itemBuilder: (context, index) {
          final borrow = provider.filteredBorrows[index];
          return _buildBorrowCard(borrow);
        },
      ),
    );
  }

  Widget _buildBorrowCard(BorrowRecord borrow) {
    final isOverdue = borrow.status == BorrowStatus.overdue;
    final isReturned = borrow.status == BorrowStatus.returned;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isOverdue ? Border.all(color: AppColors.error, width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.menu_book, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        borrow.bookTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        borrow.memberName,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(borrow.status),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateInfo(
                  context.l10n.borrowDate,
                  _formatDate(borrow.borrowDate),
                ),
                _buildDateInfo(
                  context.l10n.dueDate,
                  _formatDate(borrow.dueDate),
                  isWarning: isOverdue,
                ),
                if (isReturned)
                  _buildDateInfo(
                    context.l10n.returnDate,
                    _formatDate(borrow.returnDate!),
                  ),
              ],
            ),
            if (!isReturned) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => provider.returnBook(borrow.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.success,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(context.l10n.returnBook),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(BorrowStatus status) {
    Color color;
    String text;
    switch (status) {
      case BorrowStatus.borrowed:
        color = AppColors.info;
        text = context.l10n.borrowed;
        break;
      case BorrowStatus.overdue:
        color = AppColors.error;
        text = context.l10n.overdue;
        break;
      case BorrowStatus.returned:
        color = AppColors.success;
        text = context.l10n.returned;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateInfo(String label, String date, {bool isWarning = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.grey,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: isWarning ? AppColors.error : AppColors.greyDark,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  @override
  BorrowListVM create() => BorrowListVM();

  @override
  void initialise(BuildContext context) {}
}
