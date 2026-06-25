import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_hub/config/app_theme.dart';
import 'package:student_hub/models/student_model.dart';
import 'package:student_hub/viewmodels/student_detail_viewmodel.dart';
import 'package:student_hub/widgets/error_widget.dart';
import 'package:student_hub/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// Student Detail Screen
/// Features:
/// - Display full student information
/// - Click to open email/phone/website
/// - Loading and error states
/// - Back navigation
/// - Uses actual API data only (no fake metrics)
class StudentDetailScreen extends StatefulWidget {
  /// Student ID to load
  final int studentId;

  const StudentDetailScreen({Key? key, required this.studentId})
    : super(key: key);

  @override
  State<StudentDetailScreen> createState() => _StudentDetailScreenState();
}

class _StudentDetailScreenState extends State<StudentDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Load student detail when screen opens
    Future.microtask(() {
      context.read<StudentDetailViewModel>().loadStudentDetail(
        widget.studentId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final detailViewModel = context.watch<StudentDetailViewModel>();

    return Scaffold(
      // ============ App Bar ============
      appBar: AppBar(
        title: const Text('Student Details'),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      // ============ Body ============
      body: Stack(
        children: [
          _buildContent(context, detailViewModel),

          // Error banner
          if (detailViewModel.errorMessage != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: AppColors.error),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        detailViewModel.errorMessage!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: AppColors.error),
                      onPressed: detailViewModel.clearError,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ============ Content Builder ============

  Widget _buildContent(BuildContext context, StudentDetailViewModel viewModel) {
    // Loading state
    if (viewModel.isLoading) {
      return const LoadingWidget(message: 'Loading student details...');
    }

    // Error state
    if (viewModel.errorMessage != null && viewModel.student == null) {
      return ErrorDisplayWidget(
        message: viewModel.errorMessage!,
        onRetry: () => viewModel.retryLoad(widget.studentId),
        isInline: true,
      );
    }

    // Success state - show student detail
    if (viewModel.student != null) {
      return _buildStudentDetail(context, viewModel.student!);
    }

    // Fallback
    return ErrorDisplayWidget(
      message: 'Failed to load student information',
      onRetry: () => viewModel.retryLoad(widget.studentId),
      isInline: true,
    );
  }

  Widget _buildStudentDetail(BuildContext context, Student student) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // ============ Header Card ============
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryBlue.withOpacity(0.3),
                  AppColors.secondaryPurple.withOpacity(0.2),
                ],
              ),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Avatar with Student ID
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryBlue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${student.id}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Student Name
                Text(
                  student.name,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 8),

                // Student ID Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryPurple.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.secondaryPurple.withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    'ID: ${student.id}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.secondaryPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // ============ Information Sections ============
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============ Contact Information Section ============
                _buildSectionTitle(context, 'Contact Information'),
                const SizedBox(height: 16),

                // Email
                _buildContactItem(
                  context: context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: student.email,
                  onTap: () => _launchEmail(student.email),
                ),

                const SizedBox(height: 12),

                // Phone
                _buildContactItem(
                  context: context,
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: student.phone,
                  onTap: () => _launchPhone(student.phone),
                ),

                const SizedBox(height: 12),

                // Website
                _buildContactItem(
                  context: context,
                  icon: Icons.language_outlined,
                  label: 'Website',
                  value: student.website,
                  onTap: () => _launchWebsite(student.website),
                ),

                const SizedBox(height: 32),

                // ============ Address Section ============
                if (student.address != null && student.address!.isNotEmpty) ...[
                  _buildSectionTitle(context, 'Address'),
                  const SizedBox(height: 16),
                  _buildAddressItem(context, student.address!),
                  const SizedBox(height: 32),
                ] else ...[
                  _buildSectionTitle(context, 'Address'),
                  const SizedBox(height: 16),
                  _buildNotAvailableItem(
                    context,
                    'Address information not available',
                  ),
                  const SizedBox(height: 32),
                ],

                // ============ Action Button ============
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Back to List'),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============ Helper Widgets ============

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondaryColor = isDark
        ? AppColors.textDarkSecondary
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryBlue.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                InkWell(
                  onTap: onTap,
                  child: Text(
                    value,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryBlue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_outward,
            size: 16,
            color: AppColors.primaryBlue.withOpacity(0.6),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressItem(BuildContext context, String address) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.primaryBlue.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            color: AppColors.primaryBlue,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              address,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotAvailableItem(BuildContext context, String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textSecondaryColor = isDark
        ? AppColors.textDarkSecondary
        : AppColors.textSecondary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: textSecondaryColor.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
        color: textSecondaryColor.withOpacity(0.05),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: textSecondaryColor, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: textSecondaryColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============ URL Launch Methods ============

  /// Open email client
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open email app')),
        );
      }
    }
  }

  /// Open phone dialer
  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open phone app')),
        );
      }
    }
  }

  /// Open website in browser
  Future<void> _launchWebsite(String website) async {
    String url = website;
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri websiteUri = Uri.parse(url);
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open website')));
      }
    }
  }
}
