import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Function to open URLs
  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home', 
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SafeArea( // Añade SafeArea para evitar problemas de renderizado
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: Colors.white, // Fondo blanco explícito
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Añadir verificación de imagen
                  const CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZd4QNRY8bNxWB5WI1PXYQSwiWA6-kdq95vw&s',
                    ),
                    backgroundColor: Colors.grey, // Color de fondo en caso de error de carga
                  ),
                  const SizedBox(height: 16),

                  // Información Personal con mayor contraste
                  Text(
                    'Ingeniería en Software',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Programación para Móviles II',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Nombre: María José Domínguez Costa',
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Matrícula: 213457',
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Grupo: 9B',
                    style: TextStyle(
                      fontSize: 18, 
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Link to Repository
                  ElevatedButton(
                    onPressed: () => _launchURL('https://github.com/MariaJoseDominguezCosta/chat_bot_recu'),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.link),
                        SizedBox(width: 8),
                        Text('Ver Repositorio'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}