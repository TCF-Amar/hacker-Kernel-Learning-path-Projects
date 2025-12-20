import 'package:flutter/material.dart';

class Drawers extends StatelessWidget {
  const Drawers({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          DrawerHeader(
            decoration: BoxDecoration(
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "My Shop",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),


          _drawerItem(
            context,
            title: "Home",
            icon: Icons.home_outlined,
            route: "/home",
          ),

          _drawerItem(
            context,
            title: "Favorites",
            icon: Icons.favorite_border,
            route: "/favorite",
          ),

          _drawerItem(
            context,
            title: "Admin",
            icon: Icons.admin_panel_settings_outlined,
            route: "/admin",
          ),

          const SizedBox(height: 20),


        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required String title, required IconData icon, required String route}) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, route);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 26, ),
            const SizedBox(width: 18),
            Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}
