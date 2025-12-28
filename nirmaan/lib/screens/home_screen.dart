import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:porcupine_flutter/porcupine_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Speech engine
  final stt.SpeechToText speech = stt.SpeechToText();
  bool listening = false;
  String heardText = "";

  // Wake word engine
  PorcupineManager? porcupineManager;
  final String accessKey =
      "access key"; // replace later

  @override
  void initState() {
    super.initState();
    initWakeWord();
  }

  // 🚀 Initialize wake word
  Future<void> initWakeWord() async {
    try {
      porcupineManager = await PorcupineManager.fromKeywordPaths(accessKey, [
        "assets/keyword_files/nirman.ppn",
      ], wakeWordCallback);

      await porcupineManager?.start();
      debugPrint("🟢 Wake word ACTIVE — say 'Hey NIRMAN'");
    } catch (e) {
      debugPrint("❌ Wake word error: $e");
    }
  }

  // 🔥 Wake word detected
  void wakeWordCallback(int index) async {
    debugPrint("🔥 WAKE WORD DETECTED");
    await porcupineManager?.stop(); // stop wake word
    startListening();
  }

  // 🎤 Start speech recognition
  void startListening() async {
    bool available = await speech.initialize();

    if (available) {
      setState(() => listening = true);

      speech.listen(
        localeId: "en_IN",
        onResult: (result) {
          if (result.finalResult) {
            setState(() => heardText = result.recognizedWords.toLowerCase());
            handleCommand(heardText);
            stopListening();
          }
        },
      );
    }
  }

  // 🛑 Stop speech & restart wake word
  void stopListening() async {
    await speech.stop();
    setState(() => listening = false);
    await porcupineManager?.start(); // restart wake word
  }

  // 🧠 Handle commands
  void handleCommand(String command) {
    debugPrint("🎧 Command: $command");

    if (command.contains("attendance")) {
      Navigator.pushNamed(context, "/attendance");
    } else if (command.contains("task") || command.contains("today")) {
      Navigator.pushNamed(context, "/tasks");
    } else if (command.contains("camera") || command.contains("dpr")) {
      Navigator.pushNamed(context, "/dpr");
    }
  }

  @override
  void dispose() {
    porcupineManager?.stop();
    porcupineManager?.delete();
    speech.stop();
    super.dispose();
  }

  // 🎨 UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("👷 Nirmaan Assistant"),
        backgroundColor: Colors.yellow.shade600,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              listening ? "🎤 Listening..." : "Say: Hey NIRMAN to activate",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/attendance"),
              child: const Text("📍 Attendance"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/tasks"),
              child: const Text("📝 Tasks"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, "/dpr"),
              child: const Text("📸 DPR"),
            ),

            const SizedBox(height: 30),
            Text(
              heardText.isEmpty ? "No command yet" : "👉 Heard: $heardText",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: listening ? Colors.red : Colors.green,
        onPressed: listening ? stopListening : startListening,
        child: Icon(listening ? Icons.mic_off : Icons.mic, color: Colors.white),
      ),
    );
  }
}
