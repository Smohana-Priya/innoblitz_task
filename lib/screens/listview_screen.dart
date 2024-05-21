
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../modal/user_modal.dart';

class ListviewScreen extends StatefulWidget {
  const ListviewScreen({super.key});

  @override
  State<ListviewScreen> createState() => _ListviewScreenState();
}

class _ListviewScreenState extends State<ListviewScreen> {
   List<UserModel>? users;




@override
  void initState() {
  getData();
    super.initState();
  }
    void getData() async {
          final dio = Dio();
  final response = await dio.get('https://jsonplaceholder.typicode.com/users');
  // print(response.data);
  setState(() {
  users = (response.data as List)
      .map((json) => UserModel.fromJson(json))
      .toList();
  });



}
void openMap(String lat,String lng) async{
     if (Platform.isAndroid) {
      final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    } else {
   
      final url = 'https://maps.apple.com/?q=$lat,$lng';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } 
   
       else {
        throw 'Could not launch $url';
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('ListView Screen'),centerTitle: true,),
      body: users != null ?  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        const  SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Text('User Current Location',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users!.length,
              itemBuilder: (context,index){
                final String? lat = users![index].address!.geo!.lat;
                final String? lng = users![index].address!.geo!.lng;
                print(lat);
              return Padding(
                padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: InkWell(
                  onTap: () {
openMap(lat, lng);

                  },
                  child: Container(
                   
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),border: Border.all(color: Colors.grey)),
                    child:  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Row(children: [const Text('Lat : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),Text(lat!)],),
                        Row(children: [const Text('Lng : ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),Text(lng!)],)
                      ],),
                    ),),
                ),
              );
            }),
          ),
        ],
      ) : const Center(child: CircularProgressIndicator(),)
    );
  }
}