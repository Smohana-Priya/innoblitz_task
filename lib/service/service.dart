import 'package:dio/dio.dart';

import '../modal/user_modal.dart';

class ServiceClass{
    final dio = Dio();
  void getData() async {
  final response = await dio.get('https://jsonplaceholder.typicode.com/users');
  // print(response.data);
  final List<UserModel> users = (response.data as List)
      .map((json) => UserModel.fromJson(json))
      .toList();

  print(users[0].address!.geo!.lat);

}
}