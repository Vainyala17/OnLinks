import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  // Sample data for resources
  final List<Map<String, dynamic>> _resources = [
    {"title": "Scholarship Application Form", "category": "Scholarships", "isFavorite": false},
    {"title": "Entrance Exam Registration", "category": "Exams", "isFavorite": false},
    {"title": "School Admission Form", "category": "Admissions", "isFavorite": false},
  ];

  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    // Filter resources by search query
    final filteredResources = _resources.where((resource) {
      return resource["title"].toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Education"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  labelText: "Search resources",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Quick Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.school),
                    label: const Text("Scholarships"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.edit),
                    label: const Text("Exams"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.account_balance),
                    label: const Text("Admissions"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Featured Section
              Card(
                color: Colors.blue.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: const Icon(Icons.announcement, size: 40, color: Colors.blue),
                  title: const Text("Upcoming Exam Deadline"),
                  subtitle: const Text("Register before March 10th, 2025!"),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: const Text("Learn More"),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // List of Resources
              Expanded(
                child: filteredResources.isEmpty
                    ? const Center(
                  child: Text(
                    "No resources found",
                    style: TextStyle(fontSize: 16),
                  ),
                )
                    : GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: filteredResources.length,
                  itemBuilder: (context, index) {
                    final resource = filteredResources[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              resource["title"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Text(
                            "Category: ${resource["category"]}",
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                          IconButton(
                            icon: Icon(
                              resource["isFavorite"]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: resource["isFavorite"] ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                resource["isFavorite"] = !resource["isFavorite"];
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
