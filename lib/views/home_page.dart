import 'package:movietest/models/movie_model.dart';
import 'package:movietest/views/detailpage.dart';

import '../controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchControl controller = Get.put(SearchControl());

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildSearchBar(controller),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.value.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }
        return Column(
          children: [
            Expanded(child: _buildMovieList(controller)),
          ],
        );
      }),
    );
  }

  Widget _buildSearchBar(SearchControl controller) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'ค้นหาด้วยชื่อหนัง, ปี หรือผู้กำกับ...',
        hintStyle: TextStyle(color: Colors.white),
        prefixIcon:
            const Icon(Icons.search, color: Color.fromARGB(255, 255, 255, 255)),
        filled: true,
        fillColor: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      ),
      style: const TextStyle(color: Colors.white),
      onChanged: (value) => controller.filterMovies(value),
    );
  }

  Widget _buildMovieList(SearchControl controller) {
    return ListView.builder(
      itemCount: controller.filteredMovies.length,
      itemBuilder: (context, index) {
        final Movie movie = controller.filteredMovies[index];
        return GestureDetector(
          onTap: () => Get.to(
            DetailPage(movie: movie),
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
                  // Poster Image
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(movie.poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Movie Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
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
  }
}
