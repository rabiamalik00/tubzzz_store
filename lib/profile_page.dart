import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'app_colors.dart';
import 'firebase_service.dart';
import 'auth_pages.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? get _user => FirebaseService.currentUser;

  // ── Edit Name ────────────────────────────────
  void _editName() {
    final controller =
        TextEditingController(text: FirebaseService.userName);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Edit Name',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            prefixIcon: Icon(Icons.person_outline_rounded),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textLight)),
          ),
          TextButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await FirebaseService.updateDisplayName(
                    controller.text.trim());
                if (!mounted) return;
                setState(() {});
                Navigator.pop(context);
                _showSuccess('Name updated successfully!');
              }
            },
            child: const Text('Save',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Edit Phone ───────────────────────────────
  void _editPhone() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Add Phone Number',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            prefixIcon: Icon(Icons.phone_outlined),
            hintText: '03XXXXXXXXX',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccess('Phone number saved!');
            },
            child: const Text('Save',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Edit Address ─────────────────────────────
  void _editAddress() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Delivery Address',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: TextField(
          controller: controller,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Full Address',
            prefixIcon: Icon(Icons.location_on_outlined),
            hintText: 'House #, Street, City',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textLight)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccess('Address saved!');
            },
            child: const Text('Save',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Change Password ──────────────────────────
  void _changePassword() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Change Password',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text(
            'A password reset link will be sent to your email address.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: AppColors.textLight)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (FirebaseService.userEmail.isNotEmpty) {
                await FirebaseService.sendPasswordReset(
                    FirebaseService.userEmail);
                _showSuccess('Password reset email sent!');
              }
            },
            child: const Text('Send Email',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Notifications Toggle ─────────────────────
  void _notifications() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text(
            'Push notifications will be available in the next update. Stay tuned! 🔔'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  // ── Help & Support ───────────────────────────
  void _helpSupport() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Text('Help & Support',
            style: TextStyle(fontWeight: FontWeight.w700)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SupportTile(
                icon: Icons.email_outlined,
                label: 'Email Us',
                value: 'support@tubzzzbeauty.com'),
            const SizedBox(height: 10),
            _SupportTile(
                icon: Icons.phone_outlined,
                label: 'Call Us',
                value: '+92 300 1234567'),
            const SizedBox(height: 10),
            _SupportTile(
                icon: Icons.access_time_rounded,
                label: 'Hours',
                value: 'Mon-Sat, 9am - 6pm'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close',
                style: TextStyle(color: AppColors.textLight)),
          ),
        ],
      ),
    );
  }

  // ── Logout ───────────────────────────────────
  void _logout() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error, size: 24),
            SizedBox(width: 10),
            Text('Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.textDark)),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout?',
          style: TextStyle(color: AppColors.textLight, fontSize: 14),
        ),
        actions: [
          // NO — stay on profile
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textDark,
              side: const BorderSide(color: AppColors.divider),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('No, Stay',
                style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          // YES — logout
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await FirebaseService.signOut();
              if (!mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const LoginPage(),
                  transitionsBuilder: (_, anim, __, child) =>
                      FadeTransition(opacity: anim, child: child),
                  transitionDuration: const Duration(milliseconds: 400),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Yes, Logout',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccess(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          const Icon(Icons.check_circle_outline,
              color: Colors.white, size: 18),
          const SizedBox(width: 8),
          Text(msg),
        ]),
        backgroundColor: AppColors.success,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header ──────────────────────────
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: AppColors.bannerGradient,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                  child: Column(
                    children: [
                      // Back button row
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.white,
                                  size: 18),
                            ),
                          ),
                          const Spacer(),
                          const Text('My Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700)),
                          const Spacer(),
                          const SizedBox(width: 38),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Avatar
                      Stack(
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.2),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.5),
                                  width: 3),
                            ),
                            child: _user?.photoURL != null &&
                                    _user!.photoURL!.isNotEmpty
                                ? ClipOval(
                                    child: Image.network(
                                      _user!.photoURL!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) =>
                                          _avatarWidget(),
                                    ),
                                  )
                                : _avatarWidget(),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _editName,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: const Icon(Icons.edit_rounded,
                                    size: 14,
                                    color: AppColors.primary),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        FirebaseService.userName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        FirebaseService.userEmail,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13),
                      ),
                      const SizedBox(height: 10),

                      // Verified badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: _user?.emailVerified == true
                              ? Colors.green.withOpacity(0.25)
                              : Colors.orange.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _user?.emailVerified == true
                                ? Colors.green.withOpacity(0.5)
                                : Colors.orange.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _user?.emailVerified == true
                                  ? Icons.verified_rounded
                                  : Icons.warning_amber_rounded,
                              size: 13,
                              color: _user?.emailVerified == true
                                  ? Colors.greenAccent
                                  : Colors.orangeAccent,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              _user?.emailVerified == true
                                  ? 'Email Verified'
                                  : 'Email Not Verified',
                              style: TextStyle(
                                  color: _user?.emailVerified == true
                                      ? Colors.greenAccent
                                      : Colors.orangeAccent,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Account Info ───────────────
                  const Text('Account Information',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark)),
                  const SizedBox(height: 12),

                  _InfoCard(
                    icon: Icons.person_outline_rounded,
                    label: 'Full Name',
                    value: FirebaseService.userName,
                    onTap: _editName,
                    showEdit: true,
                  ),
                  _InfoCard(
                    icon: Icons.mail_outline_rounded,
                    label: 'Email Address',
                    value: FirebaseService.userEmail.isEmpty
                        ? 'Not available'
                        : FirebaseService.userEmail,
                  ),
                  _InfoCard(
                    icon: Icons.phone_outlined,
                    label: 'Phone Number',
                    value: _user?.phoneNumber?.isEmpty != false
                        ? 'Tap to add'
                        : _user!.phoneNumber!,
                    onTap: _editPhone,
                    showEdit: true,
                  ),
                  _InfoCard(
                    icon: Icons.login_rounded,
                    label: 'Sign-in Method',
                    value: _getSignInMethod(),
                  ),

                  const SizedBox(height: 24),

                  // ── Quick Actions ──────────────
                  const Text('Quick Actions',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark)),
                  const SizedBox(height: 12),

                  _ActionTile(
                    icon: Icons.favorite_outline_rounded,
                    label: 'My Wishlist',
                    subtitle: 'View saved products',
                    color: AppColors.primary,
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Wishlist — Coming soon! 💖')),
                    ),
                  ),
                  _ActionTile(
                    icon: Icons.shopping_bag_outlined,
                    label: 'My Orders',
                    subtitle: 'Track your orders',
                    color: AppColors.brushColor,
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Orders — Coming soon! 📦')),
                    ),
                  ),
                  _ActionTile(
                    icon: Icons.location_on_outlined,
                    label: 'Delivery Address',
                    subtitle: 'Add or edit address',
                    color: AppColors.eyeshadowColor,
                    onTap: _editAddress,
                  ),
                  _ActionTile(
                    icon: Icons.lock_outline_rounded,
                    label: 'Change Password',
                    subtitle: 'Update your password',
                    color: AppColors.powderColor,
                    onTap: _changePassword,
                  ),
                  _ActionTile(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    subtitle: 'Manage alerts',
                    color: AppColors.blushColor,
                    onTap: _notifications,
                  ),
                  _ActionTile(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & Support',
                    subtitle: 'Contact us anytime',
                    color: AppColors.nailColor,
                    onTap: _helpSupport,
                  ),

                  const SizedBox(height: 28),

                  // ── Logout Button ──────────────
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error.withOpacity(0.1),
                        foregroundColor: AppColors.error,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: const BorderSide(
                              color: AppColors.error, width: 1.5),
                        ),
                      ),
                      onPressed: _logout,
                      icon: const Icon(Icons.logout_rounded, size: 20),
                      label: const Text('Logout',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700)),
                    ),
                  ),

                  const SizedBox(height: 12),
                  Center(
                    child: Text(
                      'Tubzzz Beauty v1.0.0',
                      style: TextStyle(
                          color: AppColors.textLight.withOpacity(0.5),
                          fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarWidget() {
    return Center(
      child: Text(
        FirebaseService.userName.isNotEmpty
            ? FirebaseService.userName[0].toUpperCase()
            : 'U',
        style: const TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  String _getSignInMethod() {
    final providers = _user?.providerData ?? [];
    if (providers.isEmpty) return 'Email & Password';
    switch (providers.first.providerId) {
      case 'google.com': return 'Google';
      case 'phone': return 'Phone Number';
      default: return 'Email & Password';
    }
  }
}

// ─────────────────────────────────────────────
// Info Card
// ─────────────────────────────────────────────
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool showEdit;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.showEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: AppColors.textLight,
                          fontSize: 11,
                          fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(value,
                      style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            if (showEdit)
              const Icon(Icons.edit_outlined,
                  size: 16, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Action Tile
// ─────────────────────────────────────────────
class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: const TextStyle(
                          color: AppColors.textDark,
                          fontSize: 14,
                          fontWeight: FontWeight.w600)),
                  Text(subtitle,
                      style: const TextStyle(
                          color: AppColors.textLight, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded,
                size: 13, color: AppColors.textLight),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Support Tile (for dialog)
// ─────────────────────────────────────────────
class _SupportTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SupportTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primary, size: 18),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(
                    color: AppColors.textLight, fontSize: 11)),
            Text(value,
                style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 13,
                    fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}