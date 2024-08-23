import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokemon_app/provider/filter_provider.dart';

class PokemonFilter extends ConsumerStatefulWidget {
  const PokemonFilter({super.key});

  @override
  ConsumerState<PokemonFilter> createState() => _PokemonFilterState();
}

class _PokemonFilterState extends ConsumerState<PokemonFilter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokemon Filter'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
        },
        child: Column(
          children: [
            SwitchListTile(
              value: ref.watch(filterProvider.notifier).psychic,
              onChanged: (value) {
                setState(() {
                  ref.read(filterProvider.notifier).psychic = value;
                });
              },
              title: const Text('Psychic'),
            ),
            SwitchListTile(
              value: ref.watch(filterProvider.notifier).poison,
              onChanged: (value) {
                setState(() {
                  ref.read(filterProvider.notifier).poison = value;
                });
              },
              title: const Text('Poison'),
            ),
            SwitchListTile(
              value: ref.watch(filterProvider.notifier).ground,
              onChanged: (value) {
                setState(() {
                  ref.read(filterProvider.notifier).ground = value;
                });
              },
              title: const Text('Ground'),
            ),
            SwitchListTile(
              value: ref.watch(filterProvider.notifier).fire,
              onChanged: (value) {
                setState(() {
                  ref.read(filterProvider.notifier).fire = value;
                });
              },
              title: const Text('Fire'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Filter')),
          ],
        ),
      ),
    );
  }
}
