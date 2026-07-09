import 'package:dependency_injection_demo/widget/architectural_matrics.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class WithoutGetItScreen extends StatelessWidget {
  final ApiService apiService;

  const WithoutGetItScreen({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Manual DI Env',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            UserProfileCard(apiService: apiService),
            const SizedBox(height: 24),
            const ArchitectureMetricsBanner(
              points: [
                "Prop Drilling: Every layout node down the tree must inherit the instance field configuration.",
                "Widget Pollution: Constructor signatures are bloated with infrastructural variables rather than visual parameters.",
                "Tight Scaffold-Level Coupling: This layout boundary remains completely un-testable in pure isolation.",
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final ApiService apiService;
  const UserProfileCard({super.key, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: apiService.fetchUserProfile(),
      builder: (context, snapshot) {
        final loading = snapshot.connectionState == ConnectionState.waiting;
        final user = snapshot.data;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: const Color(0xFFE2E8F0),
                  backgroundImage:
                      loading ? null : NetworkImage(user!.avatarUrl),
                  child:
                      loading
                          ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : null,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loading ? "Synchronizing Layer Data..." : user!.name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color:
                              loading
                                  ? const Color(0xFF94A3B8)
                                  : const Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        loading
                            ? "Retrieving dynamic entity reference"
                            : user!.email,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
