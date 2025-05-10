import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/movie_model.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;
  const DetailPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
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
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(movie.poster),
          fit: BoxFit.cover,
        ),
      ),
      child: movie.poster.isEmpty
          ? const Center(child: Icon(Icons.movie, size: 100))
          : null,
    );
  }

  Widget _buildInfoSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildInfoChip('Year', '${movie.year}'),
              const SizedBox(width: 8),
              _buildInfoChip('Director', movie.director),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, String value) {
    return Chip(
      label: Text('$label: $value'),
      backgroundColor: Colors.purple[50],
    );
  }

  Widget _buildTotal_whoas_in_movie() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        movie.totalWhoas ?? 'No total_whoas_in_movie',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
