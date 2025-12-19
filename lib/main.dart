import 'package:flutter/material.dart';

void main() {
  runApp(const FantasyApp());
}

/* ================= ROOT ================= */

class FantasyApp extends StatefulWidget {
  const FantasyApp({super.key});

  @override
  State<FantasyApp> createState() => _FantasyAppState();
}

class _FantasyAppState extends State<FantasyApp> {
  bool dark = false;
  void toggle() => setState(() => dark = !dark);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: dark ? ThemeData.dark() : ThemeData.light(),
      home: Login(dark: dark, toggle: toggle),
    );
  }
}

/* ================= LOGIN ================= */

class Login extends StatelessWidget {
  final bool dark;
  final VoidCallback toggle;

  const Login({super.key, required this.dark, required this.toggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: dark
                ? [const Color(0xFF0F2027), const Color(0xFF203A43)]
                : [const Color(0xFF56ab2f), const Color(0xFFA8E063)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.sports_soccer, size: 100, color: Colors.white),
              const SizedBox(height: 20),
              const Text(
                "Fantasy League",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              field("Email"),
              field("Password", pass: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Home(dark: dark, toggle: toggle),
                    ),
                  );
                },
                child: const Text("LOGIN"),
              ),
              TextButton(
                onPressed: toggle,
                child: const Text(
                  "Toggle Theme",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget field(String hint, {bool pass = false}) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
    child: TextField(
      obscureText: pass,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white.withOpacity(.25),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}

/* ================= HOME ================= */

class Home extends StatefulWidget {
  final bool dark;
  final VoidCallback toggle;

  const Home({super.key, required this.dark, required this.toggle});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [const Matches(), const Team(), const Ranking()];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Fantasy League"),
        actions: [
          IconButton(
            icon: Icon(widget.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.toggle,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      Login(dark: widget.dark, toggle: widget.toggle),
                ),
                (_) => false,
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.dark
                ? [const Color(0xFF141E30), const Color(0xFF243B55)]
                : [const Color(0xFFE8F5E9), const Color(0xFFC8E6C9)],
          ),
        ),
        child: pages[i],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: i,
        onTap: (x) => setState(() => i = x),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Matches"),
          BottomNavigationBarItem(icon: Icon(Icons.sports), label: "Team"),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: "Ranking",
          ),
        ],
      ),
    );
  }
}

/* ================= MATCHES ================= */

class Matches extends StatelessWidget {
  const Matches({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Match("Al Ahly", "Zamalek"),
        Match("Liverpool", "Arsenal"),
        Match("Barcelona", "Real Madrid"),
        Match("Al Ahly", "Zamalek"),
        Match("Liverpool", "Arsenal"),
        Match("Barcelona", "Real Madrid"),
      ],
    );
  }
}

class Match extends StatelessWidget {
  final String a, b;
  const Match(this.a, this.b, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.sports_soccer),
        title: Text(
          "$a  🆚  $b",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text("Today • 9:00 PM"),
      ),
    );
  }
}

/* ================= TEAM ================= */

class Team extends StatefulWidget {
  const Team({super.key});

  @override
  State<Team> createState() => _TeamState();
}

class _TeamState extends State<Team> {
  int captain = 9;
  int vice = 10;

  List<Player> players = List.generate(
    11,
    (i) => Player(
      ["GK", "LB", "CB", "CB", "RB", "LM", "CM", "CM", "RM", "ST", "ST"][i],
      "https://i.imgur.com/QCNbOAo.png",
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        const Text(
          "4-4-2 Formation",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green.shade800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                const Pitch(),
                row([0], .1),
                row([1, 2, 3, 4], .3),
                row([5, 6, 7, 8], .5),
                row([9, 10], .75),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget row(List<int> ids, double top) => Positioned(
    top: MediaQuery.of(context).size.height * top * .6,
    left: 0,
    right: 0,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: ids
          .map(
            (i) => PlayerAvatar(
              index: i,
              player: players[i],
              captain: captain == i,
              vice: vice == i,
              onCaptain: () => setState(() => captain = i),
              onVice: () => setState(() => vice = i),
              onSwap: swap,
            ),
          )
          .toList(),
    ),
  );

  void swap(int a, int b) {
    setState(() {
      final t = players[a];
      players[a] = players[b];
      players[b] = t;
    });
  }
}

/* ================= PLAYER ================= */

class Player {
  final String pos;
  final String img;
  Player(this.pos, this.img);
}

class PlayerAvatar extends StatelessWidget {
  final int index;
  final Player player;
  final bool captain, vice;
  final VoidCallback onCaptain, onVice;
  final Function(int, int) onSwap;

  const PlayerAvatar({
    super.key,
    required this.index,
    required this.player,
    required this.captain,
    required this.vice,
    required this.onCaptain,
    required this.onVice,
    required this.onSwap,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onAccept: (f) => onSwap(f, index),
      builder: (_, __, ___) => Draggable<int>(
        data: index,
        feedback: avatar(),
        childWhenDragging: Opacity(opacity: .4, child: avatar()),
        child: GestureDetector(
          onLongPress: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: const Text("Make Captain"),
                    onTap: () {
                      onCaptain();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text("Make Vice Captain"),
                    onTap: () {
                      onVice();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
          child: avatar(),
        ),
      ),
    );
  }

  Widget avatar() => Column(
    children: [
      Stack(
        children: [
          CircleAvatar(radius: 26, backgroundImage: NetworkImage(player.img)),
          if (captain) badge("C", Colors.amber),
          if (vice) badge("V", Colors.blue),
        ],
      ),
      const SizedBox(height: 4),
      Text(player.pos, style: const TextStyle(color: Colors.white)),
    ],
  );

  Widget badge(String t, Color c) => Positioned(
    right: -2,
    top: -2,
    child: CircleAvatar(
      radius: 10,
      backgroundColor: c,
      child: Text(
        t,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

/* ================= PITCH ================= */

class Pitch extends StatelessWidget {
  const Pitch({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size.infinite, painter: PitchPainter());
  }
}

class PitchPainter extends CustomPainter {
  @override
  void paint(Canvas c, Size s) {
    final p = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    c.drawRect(Rect.fromLTWH(10, 10, s.width - 20, s.height - 20), p);
    c.drawLine(Offset(10, s.height / 2), Offset(s.width - 10, s.height / 2), p);
    c.drawCircle(Offset(s.width / 2, s.height / 2), 40, p);
  }

  @override
  bool shouldRepaint(_) => false;
}

/* ================= RANKING ================= */

class Ranking extends StatelessWidget {
  const Ranking({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.emoji_events, size: 80, color: Colors.amber),
              SizedBox(height: 10),
              Text(
                "124 Points",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text("Egypt Rank: #256", style: TextStyle(fontSize: 20)),
              Text("Global Rank: #12,340", style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
