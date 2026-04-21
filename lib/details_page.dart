import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'cart_model.dart';
import 'cart_page.dart';

class ProductDetailsPage extends StatefulWidget {
  final String name;
  final String price;
  final String image;
  final String category;

  const ProductDetailsPage({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _quantity = 1;
  bool _isWishlisted = false;
  int _selectedShade = 0;

  // Mock shades
  final List<Color> _shades = [
    const Color(0xFFD4477C),
    const Color(0xFFE53935),
    const Color(0xFF8B1A4A),
    const Color(0xFFFF8FAB),
    const Color(0xFFB02055),
    const Color(0xFFF48FB1),
  ];

  double get _priceValue =>
      double.tryParse(widget.price.replaceAll(RegExp(r'[^\d.]'), '')) ?? 0.0;

  void _addToCart() {
    for (int i = 0; i < _quantity; i++) {
      cartManager.addItem(CartItem(
        name: widget.name,
        price: widget.price,
        image: widget.image,
        category: widget.category,
      ));
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline,
                color: Colors.white, size: 18),
            const SizedBox(width: 8),
            Text('${widget.name} added to Cart!'),
          ],
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          textColor: AppColors.primaryLight,
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CartPage()),
          ),
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // ── Sliver App Bar with Image ────────────
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: Colors.white,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: AppColors.primary, size: 18),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  setState(() => _isWishlisted = !_isWishlisted);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(_isWishlisted
                          ? 'Added to wishlist!'
                          : 'Removed from wishlist'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      _isWishlisted
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: _isWishlisted ? Colors.red : AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.primarySoft,
                  child: const Center(
                    child: Icon(Icons.image_outlined,
                        color: AppColors.primaryLight, size: 80),
                  ),
                ),
              ),
            ),
          ),

          // ── Product Details ──────────────────────
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category chip
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.category,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Product name
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Rating + Reviews
                    Row(
                      children: [
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                            color: AppColors.gold,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text('4.8',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                                fontSize: 13)),
                        const SizedBox(width: 4),
                        const Text('(124 reviews)',
                            style: TextStyle(
                                color: AppColors.textLight, fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Price + Quantity
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '\$${(_priceValue * _quantity).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                          ),
                        ),
                        if (_quantity > 1) ...[
                          const SizedBox(width: 6),
                          Text(
                            '(${widget.price} each)',
                            style: const TextStyle(
                                color: AppColors.textLight, fontSize: 12),
                          ),
                        ],
                        const Spacer(),
                        // Quantity selector
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.divider),
                          ),
                          child: Row(
                            children: [
                              _QtyButton(
                                icon: Icons.remove_rounded,
                                onTap: () {
                                  if (_quantity > 1)
                                    setState(() => _quantity--);
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: Text(
                                  '$_quantity',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: AppColors.textDark),
                                ),
                              ),
                              _QtyButton(
                                icon: Icons.add_rounded,
                                onTap: () => setState(() => _quantity++),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: 16),

                    // Shade selector
                    const Text(
                      'Select Shade',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: List.generate(_shades.length, (i) {
                        return GestureDetector(
                          onTap: () => setState(() => _selectedShade = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 10),
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: _shades[i],
                              shape: BoxShape.circle,
                              border: _selectedShade == i
                                  ? Border.all(
                                      color: AppColors.textDark, width: 2.5)
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: _shades[i].withOpacity(0.4),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: _selectedShade == i
                                ? const Icon(Icons.check_rounded,
                                    color: Colors.white, size: 16)
                                : null,
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 22),
                    const Divider(color: AppColors.divider),
                    const SizedBox(height: 16),

                    // Description
                    const Text(
                      'Product Description',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textDark),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'This premium ${widget.category.toLowerCase()} from Tubzzz Beauty is specially curated to elevate your beauty routine. Formulated with skin-loving ingredients, it delivers long-lasting wear and a flawless finish perfect for every occasion.\n\n• Long-lasting formula\n• Dermatologically tested\n• Cruelty-free & vegan\n• Available in multiple shades',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textMedium,
                        height: 1.65,
                      ),
                    ),

                    // Info chips
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _InfoChip(label: '🌿 Cruelty Free'),
                        _InfoChip(label: '💧 Hydrating'),
                        _InfoChip(label: '⏱ Long Lasting'),
                        _InfoChip(label: '✅ Derma Tested'),
                      ],
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      // ── Bottom Buttons ────────────────────────
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Add to Cart
            Expanded(
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary, width: 1.8),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _addToCart,
                icon: const Icon(Icons.shopping_bag_outlined, size: 18),
                label: const Text('Add to Cart',
                    style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
            const SizedBox(width: 12),
            // Buy Now
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 4,
                  shadowColor: AppColors.primary.withOpacity(0.4),
                ),
                onPressed: () {
                  _addToCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  );
                },
                child: const Text('Buy Now',
                    style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Helper Widgets
// ─────────────────────────────────────────────
class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  const _InfoChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.divider),
      ),
      child: Text(
        label,
        style: const TextStyle(
            fontSize: 12,
            color: AppColors.textMedium,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}