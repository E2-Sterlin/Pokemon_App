import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/provider/filter_provider.dart';
import 'package:pokemon_app/screens/pokemon_detail_screen.dart';
import 'package:pokemon_app/screens/pokemon_filter_screen.dart';

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
  List<Map<String, dynamic>> filteredList = [];
  Set<String> filterList = {};

  void getList() async {
    pokemonList = await PokemonApi().getPokemonSearch();
  }

  void filterPokemon() {
    List<Map<String, dynamic>> filteredPok = [];
    bool isFilter = false;
    for (var pokemon in pokemonList) {
      List pokTypes = pokemon['types'];
      for (int i = 0; i < pokTypes.length; i++) {
        for (int j = 0; j < filterList.length; j++) {
          if (pokTypes[i] == filterList.elementAt(j)) {
            isFilter = true;
          }
        }
      }
      if (isFilter) {
        filteredPok.add(pokemon);
        isFilter = false;
      }
    }

    setState(() {
      if (filteredPok.isNotEmpty) {
        filteredList = filteredPok;
      } else {
        filteredList = pokemonList;
      }
    });
  }

  void searchPokemon(String searchName) {
    filterPokemon();
    resultList = filteredList.where((pokemon) {
      return pokemon['name'].toLowerCase().contains(searchName.toLowerCase());
    }).toList();

    setState(() {
      searchedPokemon = resultList;
      filterList = {};
    });
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    Widget showSearchedPokemon = Expanded(
      child: ListView.builder(
        itemCount: searchedPokemon.length,
        itemBuilder: (context, index) {
          {
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PokemonDetailScreen(
                          number: searchedPokemon[index]['number'],
                          title: searchedPokemon[index]['name']),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(searchedPokemon[index]['name']),
                ),
              ),
            );
          }
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Search'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PokemonFilter(),
                ));
              },
              icon: const Icon(Icons.sort))
        ],
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              if (ref.read(filterProvider.notifier).fire) {
                filterList.add('Fire');
              }
              if (ref.read(filterProvider.notifier).ground) {
                filterList.add('Ground');
              }
              if (ref.read(filterProvider.notifier).poison) {
                filterList.add('Poison');
              }
              if (ref.read(filterProvider.notifier).psychic) {
                filterList.add('Psychic');
              }
              searchPokemon(value);
            },
            decoration: const InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          if (searchedPokemon.isEmpty)
            const Center(
              child: Text('No Pokemon found'),
            ),
          showSearchedPokemon,
        ],
      ),
    );
  }
}
