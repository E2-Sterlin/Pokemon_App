import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/main.dart';
import 'package:pokemon_app/screens/pokemon_detail_screen.dart';
import 'package:pokemon_app/screens/pokemon_search_screen.dart';

class PokemonHomeScreen extends ConsumerWidget {
  const PokemonHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemonData = ref.watch(pokemonDataProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemons'),
        centerTitle: true,
      ),
      body: pokemonData.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PokemonDetailScreen(
                      number: data[index].number.toString(),
                      title: data[index].pokemonName.toString(),
                    ),
                  ),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Image.network(data[index].pokemonImage.toString()),
                  ),
                  title: Text(data[index].pokemonName.toString()),
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Text(error.toString()),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const PokemonSearchScreen(),
          ),
        ),
        child: const Icon(Icons.search),
      ),
    );
  }
}
