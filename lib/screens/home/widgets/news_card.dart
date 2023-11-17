import 'package:flutter/material.dart';
import 'package:pokemon_animation/constants/colors.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.time,
    required this.title,
    required this.thumbnail,
  });
  final String time;
  final String title;
  final ImageProvider thumbnail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      child: Row(
        children: [
          Expanded(child: _buildContent(context)),
          const SizedBox(width: 36),
          Image(image: thumbnail, width: 110, height: 66),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          time,
          style: const TextStyle(fontSize: 10, color: AppColors.darkGrey),
        )
      ],
    );
  }
}
