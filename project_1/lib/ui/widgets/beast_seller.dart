import 'package:flutter/material.dart';
import 'package:project_1/ui/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../../controllers/product_controller.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductController>(
      builder: (context, pc, _) {
        final bestSeller = pc.bestSellerProducts;

        return SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return RepaintBoundary( // 🔥 important
                child: ProductCard(
                  product: bestSeller[index],
                ),
              );
            },
            childCount: bestSeller.length,
          ),
        );
      },
    );
  }
}
