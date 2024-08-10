// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker_web/image_picker_web.dart';

void main() {
  // Gemini.init(
  //     apiKey: 'AIzaSyCKLL1KxCeuLKh3qsYWWpWYZlryKs422I4',
  //     version: "gemini-1.5-flash-latest");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData appTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.secondary,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.textPrimary),
        bodyMedium: TextStyle(color: AppColors.textSecondary),
      ),
      // ... other theme properties
    );
    ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkSecondary,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.darkTextPrimary),
        bodyMedium: TextStyle(color: AppColors.darkTextSecondary),
      ),
      // ... other dark theme properties
    );
    return MaterialApp(
      title: 'Ai Caption Generetor',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MyHomePage(title: 'Ai Caption Generetor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  Image? fromPicker;
  bool imgselected = false;
  bool loading = false;
  Uint8List? image;
  String cap = "this is generated caption of image !";
  // final gemini = Gemini.instance;
  final model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: "AIzaSyCKLL1KxCeuLKh3qsYWWpWYZlryKs422I4",
  );

  Future<void> selectimg() async {
    // fromPicker = await ImagePickerWeb.getImageAsBytes();
    image = await ImagePickerWeb.getImageAsBytes();
    imgselected = true;
    setState(() {});
    final type = image!.runtimeType;
    print(type);
  }

  void close() {
    setState(() {
      imgselected = false;
      image = null;
      cap = "this is generated caption of image !";
      ;
    });
  }

  Future<void> caption_generate() async {
    setState(() {
      loading = true;
    });

    final con = Content.multi([
      TextPart("Write a humorous caption for this image."),
      DataPart('image/jpeg', image!), // Pass the image as DataPart
    ]);
    await model.generateContent([con]).then((val) {
      setState(() {
        cap = val.text!;
      });
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          Tooltip(
              message: "cancle img",
              child: IconButton(
                  onPressed: () async {
                    close();
                  },
                  icon: const Icon(Icons.close))),
          const SizedBox(
            width: 20,
          ),
          Tooltip(
              message: "select image",
              child: IconButton(
                  onPressed: () async {
                    await selectimg();
                  },
                  icon: const Icon(Icons.image_search))),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:
              imgselected ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            imgselected
                ? Image.memory(
                    image!,
                    height: MediaQuery.of(context).size.height / 2,
                    fit: BoxFit.fill,
                  )
                : const Text("Select img from cliking appbar img tbn"),
            const SizedBox(
              height: 20,
            ),
            Text(imgselected ? cap : "")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (image == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("First select img"),
                duration: Duration(seconds: 2), // Adjust duration as needed
              ),
            );
          } else {
            setState(() {
              caption_generate();
              // loading = true;
            });
          }
        },
        tooltip: 'Generate Caption',
        label: const Text('Generate Caption'),
        icon: loading
            ? const CircularProgressIndicator()
            : const Icon(Icons.generating_tokens_outlined),
      ),
    );
  }
}

class AppColors {
  static const Color primary = Color(0xFF007AFF); // Blue (adjust as needed)
  static const Color secondary =
      Color(0xFFF2F2F2); // Light Grey (for background)
  static const Color textPrimary =
      Color(0xFF333333); // Dark Grey (for primary text)
  static const Color textSecondary =
      Color(0xFF888888); // Light Grey (for secondary text)
  static const Color accent = Color(0xFFF5A623); // Yellow (for accents)
  static const Color error = Color(0xFFF44336); // Red (for errors)

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF0096FF); // Darker Blue
  static const Color darkSecondary =
      Color(0xFF202023); // Dark Grey (for background)
  static const Color darkTextPrimary =
      Color(0xFFFFFFFF); // White (for primary text)
  static const Color darkTextSecondary =
      Color(0xBEFFFFFF); // Light Grey (for secondary text)
  static const Color darkAccent = Color(0xFFF5A623); // Yellow (for accents)
  static const Color darkError = Color(0xFFF44336); // Red (for errors)
}
