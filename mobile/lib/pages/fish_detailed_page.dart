import 'package:flutter/material.dart';

class FishDetailPage extends StatelessWidget {
  final String commonName;
  final String species;
  final String family;
  final String order;
  final String fishClass;

  const FishDetailPage({
    Key? key,
    required this.commonName,
    required this.species,
    required this.family,
    required this.order,
    required this.fishClass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme colors to match the main app
    final Color primaryColor = Colors.blue[800]!;
    final Color cardBg = Colors.blue[50]!;
    final Color chipBg = Colors.teal[100]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(commonName),
        backgroundColor: primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image placeholder area
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: cardBg,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Center(
                    child: Text(
                      commonName,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Scientific name
                      Text(
                        species,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 20,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Family
                      Row(
                        children: [
                          Icon(Icons.family_restroom,
                              color: Colors.blueGrey[300]),
                          const SizedBox(width: 8),
                          Text(
                            'Family: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(family),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Order
                      Row(
                        children: [
                          Icon(Icons.list_alt, color: Colors.blueGrey[300]),
                          const SizedBox(width: 8),
                          Text(
                            'Order: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(order),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Class
                      Row(
                        children: [
                          Icon(Icons.category, color: Colors.blueGrey[300]),
                          const SizedBox(width: 8),
                          Text(
                            'Class: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(fishClass),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Example Chip for type (you can adapt as needed)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Chip(
                          label: Text('More details coming soon'),
                          backgroundColor: chipBg,
                          labelStyle: TextStyle(color: primaryColor),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
