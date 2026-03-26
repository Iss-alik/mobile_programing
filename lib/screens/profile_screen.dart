import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/profile/profile_bloc.dart';
import '../blocs/profile/profile_state.dart';
import '../blocs/profile/profile_event.dart';
import 'package:flutter_application_3/utils/rest_api.dart';
import 'package:flutter_application_3/repositories/profile_repo.dart';
import 'package:flutter_application_3/models/user.dart';
import 'package:dio/dio.dart';

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
  User? _profile; // сюда будем сохранять User для отображения

  var dio;
  var api;

  @override
  void initState()
  {
    super.initState();
    dio = Dio(); // Provide a dio instance
    dio.options.headers['Demo-Header'] = 'demo header';
    api = RestClient(dio);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileSuccess) {
          setState(() {
            _profile = state.profile; // сохраняем данные для отображения
          });
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // --- TextField для ввода id ---
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Введите ID профиля',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // --- Кнопка для запроса ---
              ElevatedButton(
                onPressed: () {
                  final id = _controller.text.trim();
                  if (id.isNotEmpty) {
                    // TODO: вызываешь свой ивент здесь
                    context.read<ProfileBloc>().add(LoadProfileEvent(id, api));
                  }
                },
                child: Text('Загрузить профиль'),
              ),
              const SizedBox(height: 24),

              // --- Отображение данных профиля ---
              _profile == null
                  ? Text('Профиль пока не загружен')
                  : Expanded(
                      child: ListView(
                        children: [
                          Text('ID: ${_profile!.id ?? "-"}'),
                          Text('Name: ${_profile!.name ?? "-"}'),
                          Text('Email: ${_profile!.email ?? "-"}'),
                          Text(
                            'Company: ${_profile!.company?.name ?? "-"}',
                          ),
                          Text(
                            'CatchPhrase: ${_profile!.company?.catchPhrase ?? "-"}',
                          ),
                          Text(
                            'BS: ${_profile!.company?.bs ?? "-"}',
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}