import 'package:flutter/material.dart';
import 'package:project_1/ui/widgets/beast_seller.dart';
import 'package:project_1/ui/widgets/hero_section.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HeroSection(),
        ),

        BestSeller()
      ],
    );
  }
}
