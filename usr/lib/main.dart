import 'package:flutter/material.dart';
import 'widgets/searchable_dropdown.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Searchable Dropdown Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Searchable Dropdown Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> branchOptions = [
    'Branch A',
    'Branch B',
    'Branch C',
    'Branch D',
    'Branch E',
    'Branch F',
  ];
  String? selectedBranch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchableDropdown<String>(
              items: branchOptions,
              label: 'Select Branch',
              itemToString: (item) => item,
              selectedValue: selectedBranch,
              onChanged: (value) {
                setState(() {
                  selectedBranch = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              selectedBranch != null
                  ? 'Selected Branch: $selectedBranch'
                  : 'No branch selected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ),
    );
  }
}