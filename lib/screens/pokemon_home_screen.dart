import 'package:flutter/material.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/screens/pokemon_detail_screen.dart';
import 'package:pokemon_app/screens/pokemon_search_screen.dart';

class PokemonHomeScreen extends StatelessWidget {
  const PokemonHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemons'),
          centerTitle: true,
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PokemonSearchScreen(),
                    ))),
          ],
        ),
        body: FutureBuilder(
          future: PokemonApi().getPokemon(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                          number: snapshot.data![index].number!,
                          title:snapshot.data![index].pokemonName!,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child:
                            Image.network(snapshot.data![index].pokemonImage!),
                      ),
                      title: Text(snapshot.data![index].pokemonName!),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Text('No data');
          },
        ));
  }
}
