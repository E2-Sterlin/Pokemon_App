import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/model/pokemon.dart';
import 'package:pokemon_app/screens/pokemon_home_screen.dart';

final apiProvider = Provider<PokemonApi>((ref) => PokemonApi());
final pokemonDataProvider = FutureProvider<List<Pokemon>>((ref) {
  return ref.read(apiProvider).getPokemon();
});
final pokemonSearchProvider = FutureProvider<List<Map<String, dynamic>>>((ref) {
  return ref.read(apiProvider).getPokemonSearch();
});
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PokemonHomeScreen(),
    );
  }
}
