import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:roomrental_app/shared/colors/AppColor.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final imageList = [
    'assets/images/LivingRoom.jpg',
    'assets/images/SingleBedRoom.jpg',
    'assets/images/SplashScreen.jpg',
    'assets/images/TwinBedRoom.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.BgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Rooms',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '2 rooms on your shortlist',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.navShadowColor,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildcardRoom(
                      '\$280 / month',
                      'Family Suite',
                      'Riverside Loft',
                      '45 sqm',
                      '4 people',
                      'Move in now',
                      'Suite',
                    ),
                    _buildcardRoom(
                      '\$220 / month',
                      'Deluxe Studio',
                      'Sunrise Residence',
                      '30 sqm',
                      '2 people',
                      'Move in now',
                      'Studio',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildcardRoom(
    String price,
    String roomName,
    String buildingName,
    String areaSqm,
    String maxOccupancy,
    String status,
    String roomType,
  ) {
    return Container(
      width: double.infinity, // fixed width fixes the infinite-width crash
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140F1530),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image with badges on top of it
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(imageList[0], fit: BoxFit.cover),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.navShadowColor.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Iconsax.heart5,
                        color: AppColors.error,
                        size: 18,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.navShadowColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        price,
                        style: const TextStyle(
                          color: AppColors.BgColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        roomName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textLight,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      roomType,
                      style: const TextStyle(
                        color: AppColors.navGradientStart,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  buildingName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.txtColortitle,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Iconsax.maximize_3,
                      size: 16,
                      color: AppColors.txtColortitle,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      areaSqm,
                      style: const TextStyle(
                        color: AppColors.txtColortitle,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Iconsax.people,
                      size: 16,
                      color: AppColors.txtColortitle,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      maxOccupancy,
                      style: const TextStyle(
                        color: AppColors.txtColortitle,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Iconsax.calendar_tick,
                      size: 16,
                      color: AppColors.success,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: const TextStyle(
                        color: AppColors.success,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
