import 'package:flutter/material.dart';

void main() {
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RN Tic-Tac-Toe',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('RN Tic-Tac-Toe'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  حقل لإدخال اسم المستخدم
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Enter your username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // زرين لإنشاء اللعبة أو الانضمام إليها
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GamePage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Create'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Join'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> board =
      List.filled(9, ''); // Game board - لوحة اللعبة مكونة من 9 خلايا فارغة
  String currentPlayer = 'X'; // Current player - اللاعب الحالي (X أو O)

  // Handle tap on a cell - معالجة النقر على خلية معينة
  void _handleTap(int index) {
    if (board[index].isEmpty) {
      setState(() {
        board[index] = currentPlayer; // تحديث الخلية بالقيمة الحالية للاعب
        currentPlayer =
            currentPlayer == 'X' ? 'O' : 'X'; // التبديل بين اللاعبين
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RN Tic-Tac-Toe'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Game board grid - شبكة اللعبة
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              itemCount: 9,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _handleTap(index), // عند النقر على خلية
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black), // حدود الخلية
                    ),
                    child: Center(
                      child: Text(
                        board[index], // محتوى الخلية (X أو O)
                        style: const TextStyle(
                          fontSize: 54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Display current player scores - عرض نقاط اللاعبين
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Player X (X)',
                    style: TextStyle(fontSize: 25)), // اللاعب X
                Text('Player O (O)',
                    style: TextStyle(fontSize: 25)), // اللاعب O
              ],
            ),
          ),
        ],
      ),
    );
  }
}
