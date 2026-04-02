import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile/profile_bloc.dart';
import '../blocs/profile/profile_state.dart';
import '../blocs/profile/profile_event.dart';
import 'package:flutter_application_3/utils/rest_api.dart';
import 'package:flutter_application_3/repositories/profile_repo.dart';
import 'package:flutter_application_3/models/user.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  final ProfileRepo repo = ProfileRepo();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(repo),
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: ProfileView(),
      ),
    );
  }
}


class ProfileView extends StatefulWidget{
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _controller = TextEditingController();
  late bool _showSuccessAnimation;

  var dio;
  var api;

  @override
  void initState()
  {
    _showSuccessAnimation = false;
    super.initState();
    api = RestClient();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
              children: [
                // --- СТАТИЧЕСКАЯ ЧАСТЬ (НЕ МЕНЯЕТСЯ) ---
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Введите ID профиля',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    final id = _controller.text.trim();
                    if (id.isNotEmpty) {
                      context.read<ProfileBloc>().add(LoadProfileEvent(id, api));
                      _showSuccessAnimation = false;
                    }
                  },
                  child: Text('Загрузить профиль'),
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoading) {
                        return Center(
                          child: Lottie.asset("assets/Loading.json", 
                            width: 200,
                            height: 200,
                            repeat: false
                            ),
                        );
                      }

                      if (state is ProfileSuccess) {
                        final profile = state.profile;

                        if (!_showSuccessAnimation) {
                          _showSuccessAnimation = true;

                          Future.delayed(Duration(seconds: 1), () {
                            if (mounted) setState(() {});
                          });

                          return Center(
                            child: Lottie.asset(
                              "assets/Tick.json",
                              width: 200,
                              height: 200,
                              repeat: false,
                            ),
                          );
                        }

                        return ListView(
                          children: [
                            Text('ID: ${profile.id ?? "-"}'),
                            Text('Name: ${profile.name ?? "-"}'),
                            Text('Email: ${profile.email ?? "-"}'),
                            Text('Company: ${profile.company?.name ?? "-"}'),
                          ],
                        );
                      }

                      
                      return Center(
                        child: Text('Профиль пока не загружен'),
                      );
                    },
                  ),
                ),
              ],
            );
  }
}