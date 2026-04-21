import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'cart_model.dart';
import 'cart_page.dart';
import 'details_page.dart';
import 'profile_page.dart';
import 'app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _selectedCategory = 'Lipsticks';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  int _navIndex = 0;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Lipsticks', 'icon': Icons.colorize_rounded, 'color': AppColors.lipstickColor},
    {'name': 'Powder', 'icon': Icons.grain_rounded, 'color': AppColors.powderColor},
    {'name': 'Brushes', 'icon': Icons.brush_rounded, 'color': AppColors.brushColor},
    {'name': 'Nail Paints', 'icon': Icons.auto_fix_high_rounded, 'color': AppColors.nailColor},
    {'name': 'Eyeshadow', 'icon': Icons.remove_red_eye_rounded, 'color': AppColors.eyeshadowColor},
    {'name': 'Blush', 'icon': Icons.face_retouching_natural_rounded, 'color': AppColors.blushColor},
  ];

  final Map<String, List<String>> _productNames = {
    'Lipsticks': ['Matte Liquid', 'Velvet Gloss', 'Satin Finish', 'Long-Lasting Stick', 'Creamy Nude', 'Berry Bold'],
    'Powder': ['Translucent Setting', 'Mineral Foundation', 'Matte Finishing', 'Compact Glow', 'HD Blur', 'Sun-Kissed'],
    'Brushes': ['Blending Brush', 'Contour Brush', 'Foundation Buffer', 'Angled Liner', 'Fan Highlighter', 'Kabuki Pro'],
    'Nail Paints': ['Gel Shine', 'Matte Top Coat', 'Glitter Sparkle', 'Quick Dry Neon', 'French Nude', 'Midnight Black'],
    'Eyeshadow': ['Glitter Palette', 'Matte Nude', 'Shimmer Smoke', 'Creamy Shadow', 'Bold Drama', 'Earth Tones'],
    'Blush': ['Rose Glow', 'Peach Cream', 'Shimmering Coral', 'Soft Pink Matte', 'Berry Flush', 'Golden Apricot'],
  };

  // ── Real Unsplash makeup images — har product ki apni image ──────────────
  final Map<String, List<String>> _productImages = {
    'Lipsticks': [
      'https://images.unsplash.com/photo-1586495777744-4e6232bf4e0e?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1599733594230-6b823276abcc?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1631214524020-3c69b37e2b9e?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1503236823255-94609f598e71?w=400&h=500&fit=crop',
    ],
    'Powder': [
      'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1617897903246-719242758050?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1588514912908-a9afb5df8e97?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1526758097130-bab247274f58?w=400&h=500&fit=crop',
    ],
    'Brushes': [
      'https://images.unsplash.com/photo-1487243353834-96b8ce8d6fec?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1522337360788-8b13dee7a37e?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1516975080664-ed2fc6a32937?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1583241800698-e8ab01830a52?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1619451334792-150fd785ee74?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1527799820374-dcf8d9d4a388?w=400&h=500&fit=crop',
    ],
    'Nail Paints': [
      'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1604655832782-1f0b82a1e1d6?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1604655832782-1f0b82a1e1d6?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1604654894610-df63bc536371?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1604655832782-1f0b82a1e1d6?w=400&h=500&fit=crop',
    ],
    'Eyeshadow': [
      'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1583241475880-083f84372725?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1600857062241-98e5dba7f33c?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1522335789203-aabd1fc54bc9?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?w=400&h=500&fit=crop',
    ],
    'Blush': [
      'https://images.unsplash.com/photo-1631214524020-3c69b37e2b9e?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1586495777744-4e6232bf4e0e?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1599733594230-6b823276abcc?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1556228720-195a672e8a03?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1612817288484-6f916006741a?w=400&h=500&fit=crop',
      'https://images.unsplash.com/photo-1503236823255-94609f598e71?w=400&h=500&fit=crop',
    ],
  };

  String _getProductName(String cat, int index) {
    final names = _productNames[cat] ?? ['Premium Item'];
    return '${names[index % names.length]} $cat';
  }

  double _getProductPrice(int index) => (index + 6) * 3.99 + 9.0;

  String _getImageUrl(String cat, int index) {
    final images = _productImages[cat];
    if (images != null && index < images.length) return images[index];
    return 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=400&h=500&fit=crop';
  }

  List<int> get _filteredIndices {
    if (_searchQuery.isEmpty) return List.generate(6, (i) => i);
    return List.generate(6, (i) => i).where((i) {
      final name = _getProductName(_selectedCategory, i).toLowerCase();
      return name.contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void _addToCart(String name, String price, String image) {
    cartManager.addItem(CartItem(
      name: name,
      price: price,
      image: image,
      category: _selectedCategory,
    ));
    setState(() {});
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text('$name added to Cart!')),
          ],
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: AppColors.primaryLight,
          onPressed: () => _openCart(),
        ),
      ),
    );
  }

  void _openCart() async {
    await Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── App Bar ──────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hello, Beautiful! 👋',
                            style: TextStyle(color: AppColors.textLight, fontSize: 13)),
                        const Text('Tubzzz Beauty',
                            style: TextStyle(
                                color: AppColors.textDark,
                                fontSize: 22,
                                fontWeight: FontWeight.w800)),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: _openCart,
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                blurRadius: 12,
                                offset: const Offset(0, 4))
                          ],
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.shopping_bag_outlined,
                                color: AppColors.primary, size: 24),
                            if (cartManager.itemCount > 0)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                      color: AppColors.primary, shape: BoxShape.circle),
                                  child: Center(
                                    child: Text('${cartManager.itemCount}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // ── Search Bar ───────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                child: TextField(
                  controller: _searchController,
                  onChanged: (v) => setState(() => _searchQuery = v),
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    hintStyle: const TextStyle(color: AppColors.textLight),
                    prefixIcon:
                        const Icon(Icons.search_rounded, color: AppColors.primary),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close_rounded,
                                color: AppColors.textLight),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            })
                        : null,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),

            // ── Banner ───────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  height: 175,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: AppColors.bannerGradient,
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.primary.withOpacity(0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 8))
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -20, top: -30,
                        child: Container(
                          width: 150, height: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08)),
                        ),
                      ),
                      Positioned(
                        right: 30, bottom: -40,
                        child: Container(
                          width: 120, height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.06)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(22),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('✨ SPECIAL OFFER',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1)),
                            ),
                            const SizedBox(height: 10),
                            const Text('Flat 50% OFF',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26,
                                    fontWeight: FontWeight.w800,
                                    height: 1.1)),
                            const Text('On all beauty essentials',
                                style: TextStyle(color: Colors.white70, fontSize: 12)),
                            const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Shop Now →',
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Categories ───────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                    child: Text('Shop by Category',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark)),
                  ),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _categories.length,
                      itemBuilder: (context, i) {
                        final cat = _categories[i];
                        final selected = _selectedCategory == cat['name'];
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedCategory = cat['name'];
                            _searchQuery = '';
                            _searchController.clear();
                          }),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? (cat['color'] as Color).withOpacity(0.15)
                                        : Colors.white,
                                    shape: BoxShape.circle,
                                    border: selected
                                        ? Border.all(color: cat['color'] as Color, width: 2.2)
                                        : Border.all(color: AppColors.divider, width: 1.2),
                                    boxShadow: [
                                      BoxShadow(
                                        color: selected
                                            ? (cat['color'] as Color).withOpacity(0.25)
                                            : Colors.black.withOpacity(0.05),
                                        blurRadius: selected ? 12 : 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: Icon(cat['icon'] as IconData,
                                      color: cat['color'] as Color, size: 26),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  cat['name'],
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight:
                                        selected ? FontWeight.w700 : FontWeight.w500,
                                    color: selected
                                        ? cat['color'] as Color
                                        : AppColors.textMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            // ── Products Header ──────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                child: Row(
                  children: [
                    Text(_selectedCategory,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark)),
                    const Spacer(),
                    Text('${_filteredIndices.length} items',
                        style: const TextStyle(color: AppColors.textLight, fontSize: 13)),
                  ],
                ),
              ),
            ),

            // ── Product Grid ─────────────────────────
            _filteredIndices.isEmpty
                ? SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 60),
                      child: Column(
                        children: [
                          Icon(Icons.search_off_rounded,
                              size: 60,
                              color: AppColors.textLight.withOpacity(0.5)),
                          const SizedBox(height: 12),
                          const Text('No products found',
                              style: TextStyle(
                                  color: AppColors.textLight, fontSize: 15)),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, i) {
                          final index = _filteredIndices[i];
                          final name = _getProductName(_selectedCategory, index);
                          final price =
                              '\$${_getProductPrice(index).toStringAsFixed(2)}';
                          final image = _getImageUrl(_selectedCategory, index);
                          return _ProductCard(
                            name: name,
                            price: price,
                            image: image,
                            onTap: () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailsPage(
                                    name: name,
                                    price: price,
                                    image: image,
                                    category: _selectedCategory,
                                  ),
                                ),
                              );
                              setState(() {});
                            },
                            onAddToCart: () => _addToCart(name, price, image),
                          );
                        },
                        childCount: _filteredIndices.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.63,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                    ),
                  ),

            const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
          ],
        ),
      ),

      // ── Bottom Navigation ─────────────────────
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, -4))
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _navIndex,
          onTap: (i) async {
            if (i == 2) {
              _openCart();
            } else if (i == 3) {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilePage()),
              );
              setState(() => _navIndex = 0);
            } else {
              setState(() => _navIndex = i);
            }
          },
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLight,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 11),
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home'),
            const BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_rounded),
                activeIcon: Icon(Icons.favorite_rounded),
                label: 'Wishlist'),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.shopping_bag_outlined),
                  if (cartManager.itemCount > 0)
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: const BoxDecoration(
                            color: AppColors.primary, shape: BoxShape.circle),
                        child: Center(
                          child: Text('${cartManager.itemCount}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ),
                    ),
                ],
              ),
              activeIcon: const Icon(Icons.shopping_bag_rounded),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Product Card Widget
// ─────────────────────────────────────────────
class _ProductCard extends StatelessWidget {
  final String name, price, image;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.onTap,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Image.network(
                      image,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: AppColors.primarySoft,
                          child: const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primary, strokeWidth: 2),
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) => Container(
                        color: AppColors.primarySoft,
                        child: const Center(
                          child: Icon(Icons.image_outlined,
                              color: AppColors.primaryLight, size: 40),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.favorite_border_rounded,
                          size: 16, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                          height: 1.3)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(price,
                          style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800)),
                      const Spacer(),
                      const Icon(Icons.star_rounded,
                          size: 12, color: AppColors.gold),
                      const Text('4.8',
                          style: TextStyle(
                              fontSize: 10, color: AppColors.textLight)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: onAddToCart,
                      icon: const Icon(Icons.add_shopping_cart_rounded,
                          size: 14, color: Colors.white),
                      label: const Text('Add to Cart',
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}