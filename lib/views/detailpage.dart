import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorite_controller.dart';
import '../models/movie_model.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  final FavoriteController _favoriteController = Get.put(FavoriteController());

  DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            final bool isFavorite = _favoriteController.isFavorite(movie.id);
            return IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.redAccent : Colors.white,
              ),
              onPressed: () {
                _favoriteController.toggleFavorite(movie.id);
              },
            );
          }),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPoster(),
            _buildInfoSection(),
            _buildTotal_whoas_in_movie(),
          ],
        ),
      ),
    );
  }

  Widget _buildPoster() {
    return Hero(
      tag: 'moviePoster-${movie.id}',
      child: Container(
        height: 350,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(movie.poster),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.darken,
            ),
          ),
        ),
        child: movie.poster.isEmpty
            ? const Center(
                child: Icon(Icons.movie, size: 100, color: Colors.white70))
            : null,
      ),
    );
  }

  Widget _buildInfoSection() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildInfoChip(Icons.calendar_today, '${movie.year}', context),
                const SizedBox(width: 10),
                _buildInfoChip(Icons.person, movie.director, context),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    });
  }

  Widget _buildInfoChip(IconData icon, String value, BuildContext context) {
    return Chip(
      avatar: Icon(icon,
          size: 18, color: Theme.of(context).colorScheme.onSecondaryContainer),
      label: Text(value),
      backgroundColor:
          Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.8),
      labelStyle:
          TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer),
    );
  }

  Widget _buildTotal_whoas_in_movie() {
    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber, size: 28),
            const SizedBox(width: 8),
            Text(
              '${movie.totalWhoas} Whoas!',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      );
    });
  }
}
