
import 'package:material_ui/material_ui.dart';

void main() {
  runApp(const TipApp());
}

class TipApp extends StatelessWidget {
  const TipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tip Calculator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      home: const TipPage(),
    );
  }
}

double? parseBill(String input) {
  final value = double.tryParse(input.trim());

  if (value == null || !value.isFinite || value < 0) {
    return null;
  }

  return value;
}

({double tip, double total}) computeTip(
  double bill,
  int percent,
) {
  final tip = bill * percent / 100;

  return (
    tip: tip,
    total: bill + tip,
  );
}

class TipPage extends StatefulWidget {
  const TipPage({super.key});

  @override
  State<TipPage> createState() => _TipPageState();
}

class _TipPageState extends State<TipPage> {
  final TextEditingController billController =
      TextEditingController();

  int selectedPercent = 15;

  @override
  void dispose() {
    billController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = parseBill(billController.text);

    final result = bill == null
        ? null
        : computeTip(bill, selectedPercent);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tip Calculator'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 450,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.calculate,
                  size: 65,
                  color: Colors.teal,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Calculate Your Tip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Text(
                  'Bill Amount',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: billController,
                  keyboardType:
                      const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    prefixText: '₱ ',
                    hintText: 'Enter bill amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 25),
                const Text(
                  'Select Tip Percentage',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(
                      value: 10,
                      label: Text('10%'),
                    ),
                    ButtonSegment(
                      value: 15,
                      label: Text('15%'),
                    ),
                    ButtonSegment(
                      value: 20,
                      label: Text('20%'),
                    ),
                  ],
                  selected: {selectedPercent},
                  onSelectionChanged: (selection) {
                    setState(() {
                      selectedPercent = selection.first;
                    });
                  },
                ),
                const SizedBox(height: 25),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        if (result == null)
                          const Text(
                            'Enter a valid amount',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        else ...[
                          const Text('Tip Amount'),
                          const SizedBox(height: 5),
                          Text(
                            '₱${result.tip.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const Divider(height: 30),
                          const Text('Total Amount'),
                          const SizedBox(height: 5),
                          Text(
                            '₱${result.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
