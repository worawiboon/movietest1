import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movietest/controllers/favorite_controller.dart';
import 'package:movietest/controllers/search_controller.dart';
import 'package:movietest/models/movie_model.dart';
import 'package:movietest/views/detailpage.dart'; // For navigation

class FavoritesPage extends StatelessWidget {
  final FavoriteController _favoriteController = Get.find<FavoriteController>();
  // Assuming SearchController holds all fetchable movies or provides a way to get them by ID
  final SearchControl _searchController = Get.find<SearchControl>();

  FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Movies'),
      ),
      body: Obx(() {
        // Get all movie IDs that are favorited
        final Set<String> favoriteIds = _favoriteController.favoriteMovieIds;

        if (favoriteIds.isEmpty) {
          return const Center(
            child: Text(
              'You have no favorite movies yet!\nAdd some from the home page or details page.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Filter the full list of movies to get only the favorited ones
        // This assumes _searchController.allMovies (or similar) holds all discoverable movies
        // If SearchController doesn't have an 'allMovies' list, this part needs adjustment
        // For simplicity, let's assume filteredMovies in SearchController can be used if not actively searching
        // Or ideally, SearchController would have a master list of all movies fetched.
        // For this example, let's use filteredMovies and hope it contains them if no search is active.
        final List<Movie> favoriteMovies = _searchController.filteredMovies
            .where((movie) => favoriteIds.contains(movie.id))
            .toList();

        if (favoriteMovies.isEmpty && favoriteIds.isNotEmpty) {
          // This case might happen if favorited movies are not in the current filtered list
          // (e.g., after a search that excludes them, then navigating to favorites)
          // A more robust solution would be to fetch movie details by ID if not available
          // or ensure FavoriteController can store more movie details.
          return const Center(
            child: Text(
              'Could not load details for some favorite movies.\nTry clearing search filters on the home page.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        // Re-use or adapt a movie list builder similar to HomePage
        return ListView.builder(
          itemCount: favoriteMovies.length,
          itemBuilder: (context, index) {
            final Movie movie = favoriteMovies[index];
            // You can reuse the Card layout from HomePage or create a specific one
            return ListTile(
              leading: Hero(
                tag: 'moviePoster-${movie.id}', // Ensure Hero tag consistency
                child: Image.network(movie.poster,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (c, o, s) => Icon(Icons.movie, size: 50)),
              ),
              title: Text(movie.title),
              subtitle: Text(movie.director),
              trailing: IconButton(
                icon: Icon(
                  _favoriteController.isFavorite(movie.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: _favoriteController.isFavorite(movie.id)
                      ? Colors.redAccent
                      : Colors.grey,
                ),
                onPressed: () {
                  _favoriteController.toggleFavorite(movie.id);
                },
              ),
              onTap: () => Get.to(() => DetailPage(movie: movie)),
            );
          },
        );
      }),
    );
  }
}
