import 'package:http/http.dart' as http;

Future<bool> DeleteUser(String id) async {
  final response = await http.delete(Uri.parse(""));
  if (response.statusCode == 204) {
    print("user successfully deleted");
    return true;
  } else {
    print("unable to delete user");
    return false;
  }
}
