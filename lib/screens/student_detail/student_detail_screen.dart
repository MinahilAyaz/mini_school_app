import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mini_school_app/config/app_theme.dart';
import 'package:mini_school_app/models/student_model.dart';
import 'package:mini_school_app/viewmodels/student_detail_viewmodel.dart';
import 'package:mini_school_app/widgets/loading_widget.dart';
import 'package:mini_school_app/widgets/error_widget.dart';
import 'package:url_launcher/url_launcher.dart';

/// Student Detail Screen
///
/// Features:
/// - Display full student information
/// - Click to open email/phone/website
/// - Loading and error states
/// - Back navigation
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
        title: Text('Student Details'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
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
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.error, width: 1),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: AppColors.error),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        detailViewModel.errorMessage!,
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: AppColors.error),
                      onPressed: detailViewModel.clearError,
                      constraints: BoxConstraints(minWidth: 30, minHeight: 30),
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
      return LoadingWidget(message: 'Loading student details...');
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
            color: AppColors.primaryBlue.withOpacity(0.1),
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                // Avatar
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      '${student.id}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16),

                // Name
                Text(
                  student.name,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),

                if (student.company != null) ...[
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      student.company!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ],
              ],
            ),
          ),

          SizedBox(height: 24),

          // ============ Information Sections ============
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ============ Contact Section ============
                _buildSectionTitle(context, 'Contact Information'),
                SizedBox(height: 12),

                // Email
                _buildContactItem(
                  context: context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: student.email,
                  onTap: () => _launchEmail(student.email),
                ),

                SizedBox(height: 12),

                // Phone
                _buildContactItem(
                  context: context,
                  icon: Icons.phone_outlined,
                  label: 'Phone',
                  value: student.phone,
                  onTap: () => _launchPhone(student.phone),
                ),

                SizedBox(height: 12),

                // Website
                _buildContactItem(
                  context: context,
                  icon: Icons.language_outlined,
                  label: 'Website',
                  value: student.website,
                  onTap: () => _launchWebsite(student.website),
                ),

                SizedBox(height: 32),

                // ============ Address Section ============
                if (student.address != null) ...[
                  _buildSectionTitle(context, 'Address'),
                  SizedBox(height: 12),
                  _buildAddressItem(context, student.address!),
                  SizedBox(height: 32),
                ],

                // ============ Company Section ============
                if (student.company != null) ...[
                  _buildSectionTitle(context, 'Company'),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.business_outlined,
                          color: AppColors.primaryBlue,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            student.company!,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 32),
                ],

                // ============ Action Button ============
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    label: Text('Back to List'),
                  ),
                ),

                SizedBox(height: 24),
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
      style: Theme.of(
        context,
      ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primaryBlue),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4),
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
          Icon(Icons.arrow_outward, size: 16, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildAddressItem(BuildContext context, String address) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: AppColors.primaryBlue),
          SizedBox(width: 16),
          Expanded(
            child: Text(address, style: Theme.of(context).textTheme.bodyLarge),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open email app')));
    }
  }

  /// Open phone dialer
  Future<void> _launchPhone(String phone) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open phone app')));
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Could not open website')));
    }
  }
}
