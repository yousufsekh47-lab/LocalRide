import 'package:flutter/material.dart';

void main() {
  runApp(const LocalRideApp());
}

class LocalRideApp extends StatelessWidget {
  const LocalRideApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocalRide',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      home: const LocalRideHome(),
    );
  }
}

class LocalRideHome extends StatefulWidget {
  const LocalRideHome({super.key});

  @override
  State<LocalRideHome> createState() => _LocalRideHomeState();
}

class _LocalRideHomeState extends State<LocalRideHome> {
  final fromController = TextEditingController();
  final toController = TextEditingController();

  String selectedTransport = 'সব';

  final transports = [
    'সব',
    'বাস',
    'ট্রেন',
    'অটো',
    'টোটো',
    'বাইক',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f7f6),
      appBar: AppBar(
        title: const Text(
          '🚍 LocalRide',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'যেখানেই যেতে চান, কীভাবে যাবেন জানুন',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: fromController,
              decoration: InputDecoration(
                labelText: '📍 কোথা থেকে?',
                hintText: 'যেমন: মুর্শিদাবাদ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller: toController,
              decoration: InputDecoration(
                labelText: '🎯 কোথায় যাবেন?',
                hintText: 'যেমন: কলকাতা',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'যানবাহন নির্বাচন করুন',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: transports.map((transport) {
                final selected =
                    selectedTransport == transport;

                return ChoiceChip(
                  label: Text(transport),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      selectedTransport = transport;
                    });
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  final from =
                      fromController.text.trim();
                  final to =
                      toController.text.trim();

                  if (from.isEmpty || to.isEmpty) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      const SnackBar(
                        content: Text(
                          'শুরু এবং গন্তব্য লিখুন',
                        ),
                      ),
                    );
                    return;
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchResultPage(
                        from: from,
                        to: to,
                        transport: selectedTransport,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.search),
                label: const Text('রুট খুঁজুন'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchResultPage extends StatelessWidget {
  final String from;
  final String to;
  final String transport;

  const SearchResultPage({
    super.key,
    required this.from,
    required this.to,
    required this.transport,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('রুট ফলাফল'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$from → $to',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'যানবাহন: $transport',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 24),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'বর্তমানে এই
