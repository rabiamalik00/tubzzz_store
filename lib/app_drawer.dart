import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'firebase_service.dart';
import 'auth_pages.dart';
import 'profile_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // ── Header ──────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 24,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                gradient: AppColors.bannerGradient,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar
                  Container(
                    width: 68,
                    height: 68,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(
                          color: Colors.white.withOpacity(0.5), width: 2.5),
                    ),
                    child: FirebaseService.userPhoto.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              FirebaseService.userPhoto,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _avatarText(),
                            ),
                          )
                        : _avatarText(),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    FirebaseService.isLoggedIn
                        ? FirebaseService.userName
                        : 'Guest User',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    FirebaseService.isLoggedIn
                        ? FirebaseService.userEmail
                        : 'Login to access all features',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (FirebaseService.isLoggedIn) ...[
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('✨ Premium Member',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600)),
                    ),
                  ],
                ],
              ),
            ),

            // ── Menu Items ───────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Menu
                    _SectionHeader(title: 'MAIN MENU'),
                    _DrawerItem(
                      icon: Icons.home_rounded,
                      label: 'Home',
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.person_outline_rounded,
                      label: 'My Profile',
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ProfilePage()));
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.favorite_outline_rounded,
                      label: 'My Wishlist',
                      badge: '3',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Wishlist');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.shopping_bag_outlined,
                      label: 'My Orders',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Orders');
                      },
                    ),

                    const Divider(
                        indent: 20, endIndent: 20, color: AppColors.divider),

                    // Categories
                    _SectionHeader(title: 'SHOP BY CATEGORY'),
                    _DrawerItem(
                      icon: Icons.brush_rounded,
                      label: 'Lipsticks',
                      iconColor: AppColors.lipstickColor,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.blur_circular_rounded,
                      label: 'Powder',
                      iconColor: AppColors.powderColor,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.edit_rounded,
                      label: 'Brushes',
                      iconColor: AppColors.brushColor,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.colorize_rounded,
                      label: 'Nail Paints',
                      iconColor: AppColors.nailColor,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.remove_red_eye_outlined,
                      label: 'Eyeshadow',
                      iconColor: AppColors.eyeshadowColor,
                      onTap: () => Navigator.pop(context),
                    ),
                    _DrawerItem(
                      icon: Icons.face_retouching_natural_rounded,
                      label: 'Blush',
                      iconColor: AppColors.blushColor,
                      onTap: () => Navigator.pop(context),
                    ),

                    const Divider(
                        indent: 20, endIndent: 20, color: AppColors.divider),

                    // Other
                    _SectionHeader(title: 'OTHER'),
                    _DrawerItem(
                      icon: Icons.local_offer_outlined,
                      label: 'Offers & Deals',
                      badge: 'NEW',
                      badgeColor: AppColors.success,
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Offers');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.location_on_outlined,
                      label: 'Delivery Address',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Address');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.notifications_outlined,
                      label: 'Notifications',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Notifications');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.help_outline_rounded,
                      label: 'Help & Support',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Support');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.star_outline_rounded,
                      label: 'Rate the App',
                      onTap: () {
                        Navigator.pop(context);
                        _comingSoon(context, 'Rating');
                      },
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // ── Footer — Logout ──────────────────
            Container(
              decoration: const BoxDecoration(
                border: Border(
                    top: BorderSide(color: AppColors.divider, width: 1)),
              ),
              child: FirebaseService.isLoggedIn
                  ? _DrawerItem(
                      icon: Icons.logout_rounded,
                      label: 'Logout',
                      iconColor: AppColors.error,
                      textColor: AppColors.error,
                      onTap: () async {
                        Navigator.pop(context);
                        await FirebaseService.signOut();
                        if (!context.mounted) return;
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginPage()),
                          (route) => false,
                        );
                      },
                    )
                  : _DrawerItem(
                      icon: Icons.login_rounded,
                      label: 'Login / Sign Up',
                      iconColor: AppColors.primary,
                      textColor: AppColors.primary,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginPage()),
                          (route) => false,
                        );
                      },
                    ),
            ),

            // App version
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 4),
              child: Text(
                'Tubzzz Beauty v1.0.0',
                style: TextStyle(
                    color: AppColors.textLight.withOpacity(0.5),
                    fontSize: 11),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarText() {
    final name = FirebaseService.isLoggedIn ? FirebaseService.userName : 'G';
    return Center(
      child: Text(
        name.isNotEmpty ? name[0].toUpperCase() : 'U',
        style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w800),
      ),
    );
  }

  void _comingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature — Coming soon!')),
    );
  }
}

// ─────────────────────────────────────────────
// Section Header
// ─────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
      child: Text(
        title,
        style: TextStyle(
          color: AppColors.textLight.withOpacity(0.6),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Drawer Item
// ─────────────────────────────────────────────
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? badge;
  final Color? badgeColor;
  final Color? iconColor;
  final Color? textColor;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.badge,
    this.badgeColor,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: AppColors.primarySoft,
      highlightColor: AppColors.primarySoft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: iconColor ?? AppColors.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: textColor ?? AppColors.textDark,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (badge != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: badgeColor ?? AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    badge!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}