import 'package:flutter/cupertino.dart';
import 'package:project_1/ui/widgets/list_products.dart';
import 'package:project_1/ui/widgets/search_bar.dart';

class CollectionsTab extends StatelessWidget {
  const CollectionsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        MySearchBar(focus: true),
        Expanded(
          child: ListProducts(),
        ),
      ],
    );
  }
}
