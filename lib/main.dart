// Example (don't add to real code yet):
import 'package:mini_school_app/models/student_model.dart';
import 'package:mini_school_app/models/user_model.dart';

void testModels() {
  // Test User
  final userJson = {'id': '1', 'email': 'test@example.com', 'token': 'abc123'};
  final user = User.fromJson(userJson);
  print(user.toJson()); // Should print the map back

  // Test Student
  final studentJson = {
    'id': 1,
    'name': 'John Doe',
    'email': 'john@example.com',
    'phone': '123-456',
    'website': 'example.com',
    'company': {'name': 'Company Inc'},
    'address': {'street': 'Main St', 'city': 'NYC'},
  };
  final student = Student.fromJson(studentJson);
  print(student); // Should print the student
}
