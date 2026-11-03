import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:roomrental_app/shared/colors/AppColor.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final String title = 'Hi Dalin, find a room';
  final FocusNode _searchFocusNode = FocusNode();
  final imageList = [
    'assets/images/LivingRoom.jpg',
    'assets/images/SingleBedRoom.jpg',
    'assets/images/SplashScreen.jpg',
    'assets/images/TwinBedRoom.jpg',
  ];
  static const _duration = Duration(milliseconds: 250);
  static const _curve = Curves.easeOutCubic;

  int selectedPriceIndex = 0;
  int selectedRoomTypeIndex = 0;
  int selectedPlaceIndex = 0;

  final List<String> places = [
    'All places',
    'Sunrise Residence',
    'Riverside Loft',
  ];
  final List<String> prices = [
    'Any price',
    'Under \$300',
    '\$300 - \$500',
    'Over \$500',
  ];
  final List<String> roomTypes = [
    'Any type',
    'Studio',
    'Deluxe 1-bed',
    'Twin Room',
    'Family Suite',
  ];

  final GlobalKey _stackKey = GlobalKey();
  late final List<GlobalKey> _chipKeys = List.generate(
    places.length,
    (_) => GlobalKey(),
  );
  double _pillLeft = 0;
  double _pillWidth = 0;

  String get initials {
    final name = title.split(',').first.trim().split(' ').last;
    if (name.length < 3) return name.toUpperCase();
    return (name.substring(0, 1) + name.substring(2, 3)).toUpperCase();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _movePill());
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _movePill() {
    if (!mounted) return;
    final stackBox = _stackKey.currentContext?.findRenderObject() as RenderBox?;
    final chipBox =
        _chipKeys[selectedPlaceIndex].currentContext?.findRenderObject()
            as RenderBox?;
    if (stackBox == null || chipBox == null) return;

    final offset = chipBox.localToGlobal(Offset.zero, ancestor: stackBox);
    setState(() {
      _pillLeft = offset.dx;
      _pillWidth = chipBox.size.width;
    });
  }

  void _selectPlace(int index) {
    if (index == selectedPlaceIndex) return;
    selectedPlaceIndex = index;
    WidgetsBinding.instance.addPostFrameCallback((_) => _movePill());

    final chipContext = _chipKeys[index].currentContext;
    if (chipContext != null) {
      Scrollable.ensureVisible(
        chipContext,
        alignment: 0.5,
        duration: _duration,
        curve: _curve,
      );
    }
  }

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
                _buildHeader(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildSearch()),
                    const SizedBox(width: 12),
                    _buildFilter(),
                  ],
                ),
                const SizedBox(height: 16),

                _buildPlaceTabs(),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available now',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '4 rooms ',
                      style: TextStyle(
                        color: AppColors.navGradientStart,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Column(
                  children: [
                    _buildcardRoom(
                      '\$250 / month',
                      'Deluxe 1-Bedroom',
                      'Tower A Sunrise Residence',
                      '45 sqm',
                      '2 persons',
                      'Move in now',
                      'Studio',
                    ),
                    const SizedBox(height: 12),
                    _buildcardRoom(
                      '\$180 / month',
                      'Studio Apartment',
                      'Riverside Loft',
                      '30 sqm',
                      '1 person',
                      'Available',
                      'Studio',
                    ),
                    const SizedBox(height: 12),
                    _buildcardRoom(
                      '\$320 / month',
                      'Twin Room Suite',
                      'Sunrise Residence',
                      '50 sqm',
                      '2 persons',
                      'Available',
                      'Twin Room',
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opening soon',
                      style: TextStyle(
                        color: AppColors.textLight,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Reserve before it\'s listed ',
                      style: TextStyle(
                        color: AppColors.navInactiveColorLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildcardOpeningRoom(
                        '\$280 / month',
                        'Family Suite',
                        'Riverside Loft',
                        '15th July',
                      ),
                      SizedBox(width: 12),
                      _buildcardOpeningRoom(
                        '\$220 / month',
                        'Deluxe Studio',
                        'Sunrise Residence',
                        ' 1st August',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Iconsax.location,
                    size: 16,
                    color: AppColors.txtColortitle,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Phnom Penh',
                    style: TextStyle(
                      color: AppColors.txtColortitle,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.textLight,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.navGradientStart, AppColors.navGradientEnd],
            ),
          ),
          child: Text(
            initials,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearch() {
    return ListenableBuilder(
      listenable: _searchFocusNode,
      builder: (context, _) {
        final focused = _searchFocusNode.hasFocus;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: focused ? AppColors.navGradientStart : Colors.transparent,
              width: 2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x120F1530),
                blurRadius: 20,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Iconsax.search_normal,
                color: focused
                    ? AppColors.navGradientStart
                    : AppColors.txtColortitle,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  focusNode: _searchFocusNode,
                  cursorColor: AppColors.navGradientStart,
                  onTapOutside: (_) => _searchFocusNode.unfocus(),
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textLight,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Search rooms or buildings',
                    hintStyle: TextStyle(
                      color: AppColors.txtColortitle,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilter() {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => _buildBottomFilterSheet(),
        );
      },
      child: Container(
        width: 52,
        height: 52,
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
        child: const Icon(
          Iconsax.setting_4,
          color: AppColors.textLight,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildPlaceTabs() {
    return SizedBox(
      height: 54,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Stack(
          key: _stackKey,
          children: [
            AnimatedPositioned(
              duration: _duration,
              curve: _curve,
              left: _pillLeft,
              width: _pillWidth,
              top: 0,
              bottom: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.navGradientStart,
                      AppColors.navGradientEnd,
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < places.length; i++) ...[
                  if (i > 0) const SizedBox(width: 10),
                  _buildFilterButton(places[i], i),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, int index) {
    final selected = selectedPlaceIndex == index;

    return GestureDetector(
      onTap: () => _selectPlace(index),
      child: AnimatedContainer(
        key: _chipKeys[index],
        duration: _duration,
        curve: _curve,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          // transparent when selected, so the sliding pill shows through
          color: selected ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected ? Colors.transparent : const Color(0x140F1530),
            width: 1,
          ),
          boxShadow: selected
              ? []
              : const [
                  BoxShadow(
                    color: Color(0x100F1530),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
        ),
        child: AnimatedDefaultTextStyle(
          duration: _duration,
          curve: _curve,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textLight,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          child: Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomFilterSheet() {
    return StatefulBuilder(
      builder: (context, setSheetState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // drag handle
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.txtColortitle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Filter',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Monthly budget',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < prices.length; i++)
                      _buildOptionChip(
                        prices[i],
                        selectedPriceIndex == i,
                        () => setSheetState(() => selectedPriceIndex = i),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Room type',
                  style: TextStyle(
                    color: AppColors.textLight,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (var i = 0; i < roomTypes.length; i++)
                      _buildOptionChip(
                        roomTypes[i],
                        selectedRoomTypeIndex == i,
                        () => setSheetState(() => selectedRoomTypeIndex = i),
                      ),
                  ],
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.navGradientStart,
                          AppColors.navGradientEnd,
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x557C3AED),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Show 3 rooms',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionChip(String label, bool selected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: _duration,
        curve: _curve,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: selected
                ? const [AppColors.navGradientStart, AppColors.navGradientEnd]
                : const [Colors.white, Colors.white],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected
                ? AppColors.navGradientStart
                : const Color(0x330F1530),
            width: 1,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: _duration,
          curve: _curve,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.textLight,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          child: Center(child: Text(label, textAlign: TextAlign.center)),
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
                        Iconsax.heart,
                        color: AppColors.BgColor,
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

  Widget _buildcardOpeningRoom(
    String price,
    String roomName,
    String buildingName,
    String StartDate,
  ) {
    return Container(
      width: 300,
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
              height: 150,
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
                        Iconsax.heart,
                        color: AppColors.BgColor,
                        size: 18,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textLight,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.navGradientEnd.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        StartDate,
                        style: const TextStyle(
                          color: AppColors.navGradientEnd,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
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
