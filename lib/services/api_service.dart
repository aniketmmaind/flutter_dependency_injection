import '../models/user.dart';

class ApiService {
  // Simulates a network call delay to fetch data
  Future<User> fetchUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      name: "Alex Morgan",
      email: "alex.morgan@developer.com",
      avatarUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGrPGx1z-ulM5Kd4heZCbGH3qp3DkJqrYfvPCNlCOLDw&s",
    );
  }
}
