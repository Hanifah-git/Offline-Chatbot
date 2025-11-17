import 'package:flutter/material.dart';

class DeploymentStatusScreen extends StatelessWidget {
  // Placeholder data that would come from the Prediction Model output
  final String currentZone = "Township X - High Vulnerability (Poverty & Conflict)";
  final String deploymentStrategy = "Chatbot deployment prioritized here based on ACLED/UNDP data.";

  const DeploymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deployment Status & Prediction'),
        backgroundColor: Colors.red[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Deployment Zone:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              currentZone,
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            const Divider(height: 30),
            Text(
              'Basis for Deployment (Prediction Output):',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              deploymentStrategy,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Placeholder for the Vulnerability Heatmap/Map visual
            Center(
              child: Container(
                height: 200,
                color: Colors.grey[200],
                alignment: Alignment.center,
                child: const Text('Placeholder for Vulnerability Heatmap (Folium Output)'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}