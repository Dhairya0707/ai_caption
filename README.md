# AI Caption Generator

## Overview
AI Caption Generator is a Flutter web application that allows users to upload an image and generate a humorous caption for it using the Google Generative AI model (`gemini-1.5-flash-latest`). The app features a clean, responsive UI with support for light and dark themes.

## Features
- **Image Upload**: Select images from your device using `image_picker_web`.
- **Caption Generation**: Generate humorous captions for uploaded images via the Google Generative AI API.
- **Theme Support**: Light and dark themes with customizable colors defined in `AppColors`.
- **Responsive UI**: Displays the selected image and caption, with a loading indicator during caption generation.
- **User Feedback**: Shows a snackbar if no image is selected when attempting to generate a caption.

## Prerequisites
- **Flutter**: Version 3.0.0 or higher (web support enabled).
- **Dart**: Version compatible with the Flutter version used.
- **Google Generative AI API Key**: Obtain an API key from [Google Cloud](https://cloud.google.com/) to use the `google_generative_ai` package.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd ai-caption-generator
   ```

2. **Install Dependencies**:
   Run the following command to install required packages:
   ```bash
   flutter pub get
   ```

3. **Set Up API Key**:
   - Replace the hardcoded API key in `lib/main.dart` with your own Google Generative AI API key. For better security, consider using a `.env` file with `flutter_dotenv`:
     ```dart
     final model = GenerativeModel(
       model: 'gemini-1.5-flash-latest',
       apiKey: 'YOUR_API_KEY_HERE',
     );
     ```

4. **Enable Web Support**:
   Ensure Flutter web support is enabled:
   ```bash
   flutter config --enable-web
   ```

5. **Run the App**:
   Start the app in a web browser:
   ```bash
   flutter run -d chrome
   ```

## Usage
1. **Launch the App**: Open the app in a web browser.
2. **Select an Image**: Click the image search icon (`Icons.image_search`) in the app bar to upload an image.
3. **Generate Caption**: Click the "Generate Caption" floating action button to create a humorous caption for the selected image.
4. **Clear Selection**: Click the close icon (`Icons.close`) in the app bar to reset the image and caption.
5. **View Results**: The selected image and generated caption will appear in the center of the screen.

## Project Structure
```
ai-caption-generator/
├── lib/
│   ├── main.dart        # Main app entry point, UI, and logic
├── pubspec.yaml         # Project dependencies and configuration
├── README.md            # This file
```

## Dependencies
- `flutter`: For building the UI and app structure.
- `google_generative_ai`: For interacting with the Google Generative AI API.
- `image_picker_web`: For selecting images in a web environment.

Add these to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  google_generative_ai: ^0.4.0
  image_picker_web: ^3.0.0
```

## Notes
- **Security**: Avoid hardcoding API keys in production. Use environment variables or a secure configuration method.
- **Error Handling**: The current code assumes successful image uploads and API responses. Consider adding error handling for robustness.
- **Web Compatibility**: The app is designed for web use, leveraging `image_picker_web` for image selection.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for bug reports, feature requests, or improvements.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
