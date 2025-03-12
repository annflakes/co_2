import 'package:flutter/material.dart';

class EducationalContentPage extends StatelessWidget {
  final List<Map<String, String>> content = [
    {
      'title': 'What is Color Blindness?',
      'description':
          'Color blindness is a condition where individuals have difficulty distinguishing certain colors, often due to deficiencies in the cone cells in the eyes.',
    },
    {
      'title': 'Causes of Color Blindness',
      'description':
          'Color blindness is often inherited and occurs due to genetic mutations. It can also be caused by aging, diseases, or damage to the retina.',
    },
    {
      'title': 'Types of Color Blindness',
      'description':
          'The most common types are:\n- Red-Green Color Blindness\n- Blue-Yellow Color Blindness\n- Complete Color Blindness (Achromatopsia)',
    },
    {
      'title': 'Living with Color Blindness',
      'description':
          'People with color blindness can use aids like filters, apps, or lenses. They may also adapt by relying on brightness or patterns to identify objects.',
    },
    {
      'title': 'How Color Blind People See',
      'description':
          'Depending on the type, certain colors may appear indistinguishable, muted, or altered. For example, red and green may look similar in red-green color blindness.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: content.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Educational Content'),
          bottom: TabBar(
            isScrollable: true,
            tabs: content
                .map((item) => Tab(text: item['title']!.split(' ')[0]))
                .toList(),
          ),
        ),
        body: TabBarView(
          children: content.map((item) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item['title']!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      item['description']!,
                      style: TextStyle(fontSize: 16,
                      color: Colors.white),
                      
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


