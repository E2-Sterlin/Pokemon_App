import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/screens/pokemon_detail_screen.dart';

class PokemonSearchScreen extends ConsumerStatefulWidget {
  const PokemonSearchScreen({super.key});

  @override
  ConsumerState<PokemonSearchScreen> createState() =>
      _PokemonSearchScreenState();
}

class _PokemonSearchScreenState extends ConsumerState<PokemonSearchScreen> {
  List<Map<String, dynamic>> pokemonList = [];
  List<Map<String, dynamic>> searchedPokemon = [];
  List<Map<String, dynamic>> resultList = [];

  void getList() async {
    pokemonList = await PokemonApi().getPokemonSearch();
  }

  void searchPokemon(String searchName) {
    resultList = pokemonList.where((pokemon) {
      return pokemon['name'].toLowerCase().contains(searchName.toLowerCase());
    }).toList();

    setState(() {
      searchedPokemon = resultList;
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
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
            onChanged: (value) {
              searchPokemon(value);
            },
            
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchedPokemon.length,
              itemBuilder: (context, index) {
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PokemonDetailScreen(
                            number: searchedPokemon[index]['number'],
                            title: searchedPokemon[index]['name']),
                      ));
                    },
                    child: ListTile(
                      title: Text(searchedPokemon[index]['name']),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
