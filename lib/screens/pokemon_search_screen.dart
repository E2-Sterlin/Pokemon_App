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
  List<String> filterList = [];
  var isFilterPoison = false;
  var isFilterPsychic = false;
  var isFilterGround = false;
  var isFilterFire = false;

  void getList() async {
    pokemonList = await PokemonApi().getPokemonSearch();
  }

  void getFilterList() {
    if (isFilterFire) {
      filterList.add('Fire');
    }
    if (isFilterGround) {
      filterList.add('Ground');
    }
    if (isFilterPoison) {
      filterList.add('Poison');
    }
    if (isFilterPsychic) {
      filterList.add('Psychic');
    }
    print('filterList == $filterList');
  }

  void searchPokemon(String searchName) {
    //  filterList = pokemonList.where((filterPokemon){
    //   return filterPokemon['types']
    //  })

    resultList = pokemonList.where((pokemon) {
      return pokemon['name'].toLowerCase().contains(searchName.toLowerCase());
    }).toList();

    setState(() {
      print('resultList ==> $resultList');
      searchedPokemon = resultList;
    });
  }

  void dummyMethod() {}

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    isFilterPoison = ref.watch(filterProvider.notifier).poison;
    isFilterPsychic = ref.watch(filterProvider.notifier).psychic;
    isFilterGround = ref.watch(filterProvider.notifier).ground;
    isFilterFire = ref.watch(filterProvider.notifier).fire;

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
              searchPokemon(value);
              //  print(filterMap);
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
