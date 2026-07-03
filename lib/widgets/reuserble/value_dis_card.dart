// import 'package:flutter/material.dart';

// class ValueDisCard extends StatelessWidget {
//   const ValueDisCard({
//     super.key,
//     required this._downloadRate,
//     required this.unitText,
//   });

//   final double _downloadRate;
//   final String unitText;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(18),
//         decoration: BoxDecoration(
//           color: Colors.white.withValues(alpha: .08),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           children: [
//             const Icon(Icons.download, color: Colors.greenAccent, size: 35),
//             const SizedBox(height: 10),
//             const Text('Download', style: TextStyle(color: Colors.white70)),
//             const SizedBox(height: 8),
//             Text(
//               '${_downloadRate.toStringAsFixed(2)} $unitText',
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ValueDisCard extends StatelessWidget {
  const ValueDisCard({
    super.key,
    required this.value,
    required this.unitText,
    required this.name,
    required this.icon,
    this.iconColor = Colors.greenAccent,
  });

  final double value;
  final String unitText;
  final String name;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .08),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, color: iconColor, size: 35),
            const SizedBox(height: 10),
            Text(name, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              '${value.toStringAsFixed(2)} $unitText',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
