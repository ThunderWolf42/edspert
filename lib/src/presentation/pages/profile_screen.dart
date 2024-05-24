import 'package:edspert/src/presentation/pages/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final String apiUrl =
      'https://edspert.widyaedu.com/users?email=juveticsatu@gmail.com'; // Ganti dengan URL API yang sesuai

  late Future<ProfileResponse> profile;

  @override
  void initState() {
    super.initState();
    profile = fetchProfile();
  }

  Future<ProfileResponse> fetchProfile() async {
    try {
      final response = await Dio().get(
        apiUrl,
        options: Options(
          headers: {
            'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a3',
          },
        ),
      );
      if (response.statusCode == 200) {
        return ProfileResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      throw Exception('Failed to load profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileScreen()));
              },
              child: const Text(
                "Edit",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: FutureBuilder<ProfileResponse>(
                future: profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return ProfileView(profile: snapshot.data!);
                  } else {
                    return const Center(child: Text('No data'));
                  }
                },
              ),
            ),
          ),
          TextButton(
            onPressed: (){
              
            }, 
            child: const Text("LogOut")
          )
        ],
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  final ProfileResponse profile;

  ProfileView({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Identitas Diri",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          const Text("Nama Lengkap:"),
          Text('${profile.data?.userName}',
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          const Text("Email"),
          Text('Email: ${profile.data?.userEmail}',
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          const Text("Jenis Kelamin"),
          Text('Jenis Kelamin: ${profile.data?.userGender}',
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          const Text("Kelas"),
          Text('Kelas: ${profile.data?.kelas}',
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
          const Text("Sekolah"),
          Text('Sekolah: ${profile.data?.userAsalSekolah}',
              style: const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class ProfileResponse {
  final int? status;
  final String? message;
  final Data? data;

  ProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      ProfileResponse(
        status: json["status"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final String? iduser;
  final String? userName;
  final String? userEmail;
  final String? userFoto;
  final String? userAsalSekolah;
  final DateTime? dateCreate;
  final String? jenjang;
  final String? userGender;
  final String? userStatus;
  final String? kelas;

  Data({
    this.iduser,
    this.userName,
    this.userEmail,
    this.userFoto,
    this.userAsalSekolah,
    this.dateCreate,
    this.jenjang,
    this.userGender,
    this.userStatus,
    this.kelas,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        iduser: json["iduser"],
        userName: json["user_name"],
        userEmail: json["user_email"],
        userFoto: json["user_foto"],
        userAsalSekolah: json["user_asal_sekolah"],
        dateCreate: json["date_create"] == null
            ? null
            : DateTime.parse(json["date_create"]),
        jenjang: json["jenjang"],
        userGender: json["user_gender"],
        userStatus: json["user_status"],
        kelas: json["kelas"],
      );

  Map<String, dynamic> toJson() => {
        "iduser": iduser,
        "user_name": userName,
        "user_email": userEmail,
        "user_foto": userFoto,
        "user_asal_sekolah": userAsalSekolah,
        "date_create": dateCreate?.toIso8601String(),
        "jenjang": jenjang,
        "user_gender": userGender,
        "user_status": userStatus,
        "kelas": kelas,
      };
}
