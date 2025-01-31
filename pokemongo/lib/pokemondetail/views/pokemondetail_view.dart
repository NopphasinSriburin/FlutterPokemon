import 'package:flutter/material.dart';
import 'package:pokemondex/pokemonlist/models/pokemonlist_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemondetailView extends StatefulWidget {
  final PokemonListItem pokemonListItem;

  const PokemondetailView({Key? key, required this.pokemonListItem})
      : super(key: key);

  @override
  State<PokemondetailView> createState() => _PokemondetailViewState();
}

class _PokemondetailViewState extends State<PokemondetailView> {
  Map<String, dynamic>? _pokemonDetails;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  //load data
  void loadData() async {
    final response = await http.get(Uri.parse(widget.pokemonListItem.url));
    if (response.statusCode == 200) {
      setState(() {
        _pokemonDetails = jsonDecode(response.body);
      });
    } else {
      print('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text(widget.pokemonListItem.name),
              backgroundColor: Colors.purple,
              foregroundColor: Colors.white,
            ),
            body: _pokemonDetails == null
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${_pokemonDetails!['name']}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Type: ${_pokemonDetails!['types'][0]['type']['name']}',
                            style: const TextStyle(fontSize: 20)),
                        Text('Status: ${_pokemonDetails!['status']}',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Default Status: ${_pokemonDetails!['is_default']}',
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ),
                  )));
  }
}
