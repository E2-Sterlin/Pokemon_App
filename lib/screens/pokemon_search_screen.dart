import 'package:flutter/material.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/pokemon_detail_screen.dart';

class PokemonSearchScreen extends StatefulWidget {
  const PokemonSearchScreen({super.key});

  @override
  State<PokemonSearchScreen> createState() => _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends State<PokemonSearchScreen> {
  List<String> pokemonName = [];
  String pokemonSearchName = '';
  List<String> pokemonSearchResults = [];
  List<Pokemon> pokemons = [];
  List number = [];

  void getPokemons() async {
    pokemons = await PokemonApi().getPokemon();
    for (var pokemonValue in pokemons) {
      String pokeName = pokemonValue.pokemonName!;
      pokemonName.add(pokeName);
    }
  }

  void getPokemonNumber() async {
    // for (var value in pokemons) {
    //   if (value.pokemonName == name) {
    //     pokemonNumber = value.number.toString();
    //     print('pokemonNumber ===> $pokemonNumber');
    //   }
    // }
    pokemons = await PokemonApi().getPokemon();
    for (var pokemonValue in pokemons) {
      String num = pokemonValue.number!;
      number.add(num);
    }
  }

  @override
  void initState() {
    super.initState();
    getPokemons();
    getPokemonNumber();
  }

  void pokemonSearch(String name) {
    setState(() {
      pokemonSearchResults = pokemonName
          .where((item) => item.toLowerCase().contains(name.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pokemon Search'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TextField(
              onChanged: pokemonSearch,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: pokemonSearchResults.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PokemonDetailScreen(
                          number: '006',
                          title: 'detail',
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(pokemonSearchResults[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
