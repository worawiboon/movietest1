import 'package:movietest/models/movie_model.dart';
import 'package:movietest/views/detailpage.dart';
import 'package:movietest/views/favorites_page.dart';
import 'package:movietest/views/settings_page.dart';

import '../controllers/search_controller.dart';
import '../controllers/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.put(FavoriteController());
  final SearchControl _searchController = Get.put(SearchControl());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _buildSearchBar(_searchController),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_outline, color: Colors.white),
            tooltip: 'Favorite Movies',
            onPressed: () {
              Get.to(() => FavoritesPage());
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            tooltip: 'Settings',
            onPressed: () {
              Get.to(() => SettingsPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (_searchController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (_searchController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(_searchController.errorMessage.value));
        }
        return Column(
          children: [
            Expanded(child: _buildMovieList(_searchController)),
          ],
        );
      }),
    );
  }

  Widget _buildSearchBar(SearchControl controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'ค้นหาหนังเลย...',
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        prefixIcon: const Icon(Icons.search, color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) => controller.filterMovies(value),
    );
  }

  Widget _buildMovieList(SearchControl searchController) {
    return Obx(() {
      return ListView.builder(
        itemCount: searchController.filteredMovies.length,
        itemBuilder: (context, index) {
          final Movie movie = searchController.filteredMovies[index];
          return GestureDetector(
            onTap: () => Get.to(
              () => DetailPage(movie: movie),
              transition: Transition.fadeIn,
            ),
            child: Card(
              margin: const EdgeInsets.all(8.0),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: 'moviePoster-${movie.id}',
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(movie.poster),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: movie.poster.isEmpty
                            ? const Center(child: Icon(Icons.movie, size: 50))
                            : null,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  movie.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Obx(() {
                                final bool isFavorite =
                                    _favoriteController.isFavorite(movie.id);
                                return IconButton(
                                  icon: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.redAccent
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    _favoriteController
                                        .toggleFavorite(movie.id);
                                  },
                                );
                              }),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text('Year: ${movie.year}'),
                          Text('Director: ${movie.director}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
