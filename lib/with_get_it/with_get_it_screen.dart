import 'package:dependency_injection_demo/widget/architectural_matrics.dart';
import 'package:flutter/material.dart';
import 'service_locator.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class WithGetItScreen extends StatelessWidget {
  const WithGetItScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'GetIt Registry Env',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            UserProfileCardGetIt(),
            SizedBox(height: 24),
            ArchitectureMetricsBanner(
              points: [
                "Zero Prop Drilling: Root screen abstraction interface possesses compile-safe, fully empty constructors.",
                "Lazy-Loaded Singletons: Instances allocate inside heap parameters only upon explicit extraction request invocation.",
                "Clean Component Portability: This sub-widget card can be extracted safely across alternate application tree workflows dynamically.",
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileCardGetIt extends StatelessWidget {
  const UserProfileCardGetIt({super.key});

  @override
  Widget build(BuildContext context) {
    // Isolated lookup call decoupled from UI context parameters completely
    final apiService = locator<ApiService>();

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
                        loading ? "Accessing Service Registry..." : user!.name,
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
                            ? "Injecting backend provider scope locator"
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
