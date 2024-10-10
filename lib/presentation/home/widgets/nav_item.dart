import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import 'package:badges/badges.dart' as badges;

class NavItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          label == 'Orders'
              ? badges.Badge(
                  badgeContent: const Text(
                    '0', // Replace with dynamic value if necessary
                    style: TextStyle(color: Colors.white),
                  ),
                  child: SizedBox(
                    width: 25.0,
                    height: 25.0,
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: ColorFilter.mode(
                        isActive ? AppColors.black : AppColors.disabled,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                )
              : SizedBox(
                  width: 25.0,
                  height: 25.0,
                  child: SvgPicture.asset(
                    iconPath,
                    colorFilter: ColorFilter.mode(
                      isActive ? AppColors.black : AppColors.disabled,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
          const SpaceHeight(4.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? AppColors.black : AppColors.disabled,
            ),
          ),
        ],
      ),
    );
  }
}
