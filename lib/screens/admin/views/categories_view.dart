import 'package:flutter/material.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Action Bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Color(0xFF94A3B8)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search categories...',
                          hintStyle: TextStyle(fontFamily: 'Inter', color: Color(0xFF94A3B8), fontSize: 14),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(fontFamily: 'Inter', color: Color(0xFF131B2E), fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 20),
              label: Text(isMobile ? 'Add' : 'Add Category'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 24, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                textStyle: const TextStyle(fontFamily: 'Inter', fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Categories Tree
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.06),
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: -2,
                )
              ],
            ),
            padding: const EdgeInsets.all(24),
            child: ListView(
              children: const [
                _CategoryTile(name: 'Electronics', productCount: 245, depth: 0, children: [
                  _CategoryTile(name: 'Smartphones', productCount: 89, depth: 1, children: []),
                  _CategoryTile(name: 'Laptops', productCount: 56, depth: 1, children: []),
                  _CategoryTile(name: 'Headphones', productCount: 34, depth: 1, children: []),
                ]),
                _CategoryTile(name: 'Apparel', productCount: 312, depth: 0, children: [
                  _CategoryTile(name: 'Men', productCount: 156, depth: 1, children: []),
                  _CategoryTile(name: 'Women', productCount: 128, depth: 1, children: []),
                ]),
                _CategoryTile(name: 'Home & Garden', productCount: 98, depth: 0, children: []),
                _CategoryTile(name: 'Sports & Outdoors', productCount: 67, depth: 0, children: []),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String name;
  final int productCount;
  final int depth;
  final List<_CategoryTile> children;

  const _CategoryTile({
    required this.name,
    required this.productCount,
    required this.depth,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: depth * 32.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: const Color(0xFFF1F5F9))),
            ),
            child: Row(
              children: [
                if (children.isNotEmpty)
                  const Icon(Icons.expand_more, color: Color(0xFF94A3B8), size: 20)
                else
                  const SizedBox(width: 20),
                const SizedBox(width: 12),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.folder_outlined, color: Color(0xFF475569), size: 18),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      fontWeight: depth == 0 ? FontWeight.w600 : FontWeight.w500,
                      color: const Color(0xFF131B2E),
                    ),
                  ),
                ),
                Text(
                  '$productCount products',
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Color(0xFF94A3B8), size: 20),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}
