import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:otaku/utils/colors/color.dart';

class AnimeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final String hintText;

  const AnimeSearchBar({
    super.key,
    required this.controller,
    required this.onSearch,
    this.hintText = "Search Anime...",
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgs/unlike.svg',
            height: screenHeight * 0.03,
            width: screenWidth * 0.07,
            color: AppColors.black,
          ),
          SizedBox(width: screenWidth * 0.02),
          // Search Input Field
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSearch,
              style: TextStyle(
                color: AppColors.black,
                fontSize: screenWidth * 0.04,
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColors.black,
                  fontSize: screenWidth * 0.035,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              onSearch(controller.text.trim());
            },
            icon: const Icon(
              Icons.search,
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
