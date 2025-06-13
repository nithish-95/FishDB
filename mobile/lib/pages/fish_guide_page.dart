import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'fish_detailed_page.dart';

class Fish {
  final String commonName;
  final String species;
  final String family;
  final String order;
  final String fishClass;

  Fish({
    required this.commonName,
    required this.species,
    required this.family,
    required this.order,
    required this.fishClass,
  });

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(
      commonName: json['common_name'] ?? '',
      species: json['species'] ?? '',
      family: json['family'] ?? '',
      order: json['order'] ?? '',
      fishClass: json['class'] ?? '',
    );
  }
}

class FishGuidePage extends StatefulWidget {
  const FishGuidePage({Key? key}) : super(key: key);

  @override
  State<FishGuidePage> createState() => _FishGuidePageState();
}

class _FishGuidePageState extends State<FishGuidePage> {
  List<Fish> allFish = [];
  List<Fish> filteredFish = [];
  final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;

  final List<String> popularSearches = [
    'Atlantic Salmon',
    'Yellowfin Tuna',
    'Largemouth Bass',
    'Rainbow Trout',
    'Pacific Cod',
  ];

  @override
  void initState() {
    super.initState();
    loadFishData();
  }

  Future<void> loadFishData() async {
    final String response = await rootBundle.loadString('assets/data.json');
    final data = json.decode(response);
    final List<dynamic> fishesList = data['fishes'];
    setState(() {
      allFish = fishesList.map((json) => Fish.fromJson(json)).toList();
      filteredFish = List.from(allFish);
      isLoading = false;
    });
  }

  void searchFish(String query) {
    setState(() {
      filteredFish = allFish
          .where((fish) =>
              fish.commonName.toLowerCase().contains(query.toLowerCase()) ||
              fish.species.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void onPopularSearchTap(String fishName) {
    _searchController.text = fishName;
    searchFish(fishName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FishGuide'),
        actions: [
          Row(
            children: [
              SizedBox(
                width: 16,
                child: isLoading
                    ? const CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    : const Icon(Icons.circle, color: Colors.green, size: 16),
              ),
              const SizedBox(width: 8),
              Text(
                isLoading ? 'Loading...' : 'Ready',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.more_vert),
            ],
          )
        ],
        backgroundColor: Colors.blue[800],
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: searchFish,
                      decoration: const InputDecoration(
                        hintText: 'Enter fish name (e.g., Salmon, Tuna, Bass)',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () => searchFish(_searchController.text),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Popular Searches
            const Text('Popular Searches:', style: TextStyle(fontSize: 15)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: popularSearches
                  .map((name) => ActionChip(
                        label: Text(name),
                        onPressed: () => onPopularSearchTap(name),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 24),
            // Fish Cards
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredFish.isEmpty
                      ? const Center(child: Text('No fish found.'))
                      : ListView.builder(
                          itemCount: filteredFish.length,
                          itemBuilder: (context, index) {
                            final fish = filteredFish[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FishDetailPage(
                                      commonName: fish.commonName,
                                      species: fish.species,
                                      family: fish.family,
                                      order: fish.order,
                                      fishClass: fish.fishClass,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.only(bottom: 16),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(12)),
                                      ),
                                      child: const Center(
                                        child: Icon(Icons.waves,
                                            size: 36, color: Colors.blue),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(fish.commonName,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold)),
                                          const SizedBox(height: 4),
                                          Text(fish.species,
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic)),
                                          const SizedBox(height: 8),
                                          Chip(
                                            label: Text(fish.family),
                                            backgroundColor: Colors.teal[100],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Recent'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_border), label: 'Saved'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
