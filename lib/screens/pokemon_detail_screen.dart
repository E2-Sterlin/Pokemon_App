import 'package:flutter/material.dart';
import 'package:pokemon_app/api_services/pokemon_api.dart';

class PokemonDetailScreen extends StatelessWidget {
  const PokemonDetailScreen({
    super.key,
    required this.number,
    required this.title,
  });
  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    final futureList = PokemonApi().getPokemonDetails(number);
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
                    child: Image.network(snapshot.data!.pokemonDetailsImageUrl),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Name'),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(snapshot.data!.pokemonDetailsName),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Type'),
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
                      const Text('Description'),
                      Column(
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
                      const Text('BaseStats'),
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
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
