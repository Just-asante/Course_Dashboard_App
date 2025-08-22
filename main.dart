import 'package:flutter/material.dart';

void main() {
  runApp(const CourseDashboardApp());
}

class CourseDashboardApp extends StatelessWidget {
  const CourseDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showExitDialog(context),
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: AnimatedEnrollButton(),
    );
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit Confirmation'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

class AnimatedEnrollButton extends StatefulWidget {
  const AnimatedEnrollButton({super.key});

  @override
  State<AnimatedEnrollButton> createState() => _AnimatedEnrollButtonState();
}

class _AnimatedEnrollButtonState extends State<AnimatedEnrollButton> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isTapped = true),
      onTapUp: (_) => setState(() => _isTapped = false),
      onTapCancel: () => setState(() => _isTapped = false),
      child: AnimatedScale(
        scale: _isTapped ? 1.2 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            // Handle enroll action
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Enrollment feature coming soon!')),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final List<Course> courses = [
    Course('Mobile App Development', 'Dr. Smith', Icons.phone_iphone),
    Course('Web Programming', 'Prof. Johnson', Icons.computer),
    Course('Database Systems', 'Dr. Williams', Icons.storage),
    Course('Software Engineering', 'Prof. Brown', Icons.engineering),
    Course('Data Structures', 'Dr. Davis', Icons.data_array),
  ];

  String? _selectedCategory;
  final List<String> categories = [
    'Science',
    'Arts',
    'Technology',
    'Business',
    'Health'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Course Category Dropdown
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            hint: const Text('Select Course Category'),
            items: categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCategory = newValue;
              });
            },
          ),
        ),

        // Display selected category
        if (_selectedCategory != null)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              'Selected Category: $_selectedCategory',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

        // Course List
        Expanded(
          child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return CourseCard(course: courses[index]);
            },
          ),
        ),
      ],
    );
  }
}

class Course {
  final String name;
  final String instructor;
  final IconData icon;

  Course(this.name, this.instructor, this.icon);
}

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(course.icon, size: 36),
        title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Instructor: ${course.instructor}'),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Handle course selection
        },
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Profile Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}