import 'dart:io';
import 'package:dio/dio.dart';
import 'package:edspert/src/presentation/manager/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _schoolController = TextEditingController();
  final _genderController = TextEditingController();
  final _kelasController = TextEditingController();
  final _jenjangController = TextEditingController();
  final _photoController = TextEditingController();

  var headers = {
    'x-api-key': '18be70c0-4e4d-44ff-a475-50c51ece99a3'
  };

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final nama_lengkap = _nameController.text;
      final nama_sekolah = _schoolController.text;
      final email = _emailController.text;
      final gender = _genderController.text;
      final kelas = _kelasController.text;
      final jenjang = _jenjangController.text;
      final foto = _photoController.text;

      try {
        final dio = Dio();
        final response = await dio.post(
          'https://edspert.widyaedu.com/users/registrasi',
          data: {
            'nama_lengkap': nama_lengkap, 
            'email': email,
            'nama_sekolah': nama_sekolah,
            'gender': gender,
            'kelas': kelas,
            'foto': foto,
            'jenjang': jenjang,
          },
          options: Options(
            headers: headers,
          ),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Registrasi berhasil!'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Registrasi gagal: ${response.data['error']}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Terjadi kesalahan: ${e.toString()}'),
          ),
        );
      }
    }
  }
  XFile? pickedImage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _schoolController.dispose();
    _genderController.dispose();
    _kelasController.dispose();
    _jenjangController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(controller: ScrollController(),child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                pickedImage = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                  imageQuality: 40,
                );

                setState(() {});
              },
              child: (pickedImage == null)
                  ? Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: const Icon(Icons.person_2),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.file(
                        width: 70,
                        height: 70,
                        File(pickedImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
          BlocConsumer<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is UploadImageSuccess) {
                print('Download Url: ${state.downloadUrl}');
                /// Call Api Edit Profile
              }
            },
            builder: (context, state) {
              if (state is UploadImageLoading) {
                return const CircularProgressIndicator();
              }

              return ElevatedButton(
                onPressed: () {
                  if (pickedImage == null) {
                    print('Image must be selected!');
                    return;
                  }

                  /// Upload
                  context
                      .read<ProfileBloc>()
                      .add(UploadImageEvent(pickedImage!));
                },
                child: const Text('SAVE'),
              );
            },
          ),

          Container(
            child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Nama lengkap",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.all(Radius.circular(12))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 56 ,
                      width: 311,
                      child: Center(
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration.collapsed(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                    hoverColor: Colors.transparent,
                                    hintText: '                      Example: Susanto'
                                    ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                      example@gmail.com'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!RegExp(r'^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*\.(\w{2,3})+$').hasMatch(value)) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Nama Sekolah",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _schoolController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                   SMAN 3 Bogor'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'tidak boleh kosong';
                            }
                           
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Jenis Kelamin",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _genderController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                      Laki-laki/Perempuan'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jenis Kelamin tidak boleh kosong';
                            }
                            
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Kelas",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              const SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _kelasController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                      Kelas:XX'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kelas tidak boleh kosong';
                            }
                           
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Jenjang",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _jenjangController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                      SD/SMP/SMA'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'tidak boleh kosong';
                            }
                            
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                  height: 24,
                  width: 311,
                  child: const Text(
                    "Photo",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 311,
                      height: 56,
                      child: Center(
                        child: TextFormField(
                          controller: _photoController,
                          decoration: const InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          filled: true,
                          hoverColor: Colors.transparent,
                          hintText: '                      Url'
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'photo tidak boleh kosong';
                            }
                            
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  )
                ),
                
                child: const Text('Registrasi', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),),
              ),
            ],
          ),
        ),
      ),
          )
        ],
      ),
    ));
  }
}
