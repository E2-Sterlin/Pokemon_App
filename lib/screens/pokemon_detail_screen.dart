import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';
import 'package:pokemon_app/main.dart';

class PokemonDetailScreen extends ConsumerWidget {
  const PokemonDetailScreen({
    super.key,
    required this.number,
    required this.title,
  });
  final String number;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureList = PokemonApi().getPokemonDetails(number);
    // final futureList = ref.watch(pokemonDetailProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: futureList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    child: Center(
                        child: Image.network(
                            snapshot.data!.pokemonDetailsImageUrl)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        snapshot.data!.pokemonDetailsName,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        children: List.generate(
                          snapshot.data!.pokemonDetailsTypes.length,
                          (index) {
                            return Text(
                                '${snapshot.data!.pokemonDetailsTypes[index]}  ');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          snapshot.data!.pokemonDetailsDescriptions.length,
                          (index) {
                            return Text(
                                '${index + 1}.${snapshot.data!.pokemonDetailsDescriptions[index]}');
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'BaseStats',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: List.generate(
                          snapshot.data!.pokemonDetailsBaseStats.length,
                          (index) {
                            final keys = snapshot
                                .data!.pokemonDetailsBaseStats.keys
                                .toList();
                            final value = snapshot
                                .data!.pokemonDetailsBaseStats.values
                                .toList();
                            return Row(
                              children: [
                                Text('${keys[index]} : ${value[index]}'),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          snapshot.data!.pokemonDetailsCards.length, (index) {
                        final imageUrl =
                            snapshot.data!.pokemonDetailsCards[index];
                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Image.network(
                                    imageUrl,
                                  ),
                                );
                              },
                            );
                          },
                          child: Card(
                            child: Image.network(
                              imageUrl,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Text('Error');
                              },
                            ),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
