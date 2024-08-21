import 'package:flutter/material.dart';

class DiffViewerWidget extends StatelessWidget {
  final String diff;

  const DiffViewerWidget(this.diff, {super.key});

  @override
  Widget build(BuildContext context) {
    final lines = diff.split('\n');
    int oldLineNumber = 0;
    int newLineNumber = 0;

    List<Widget> children = [];
    for (var line in lines) {
      children.add(_buildDiffLine(line, oldLineNumber, newLineNumber,
          (incrementOld, incrementNew) {
        if (incrementOld) oldLineNumber++;
        if (incrementNew) newLineNumber++;
      }));
    }

    return Wrap(
      clipBehavior: Clip.antiAlias,

      // crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  Widget _buildDiffLine(String line, int oldLineNumber, int newLineNumber,
      Function(bool, bool) updateLineNumbers) {
    if (line.startsWith('+')) {
      updateLineNumbers(false, true);
      return _buildAddedLine(line, newLineNumber);
    } else if (line.startsWith('-')) {
      updateLineNumbers(true, false);
      return _buildDeletedLine(line, oldLineNumber);
    } else if (line.startsWith('@@')) {
      // Extract line numbers from the diff header
      final match = RegExp(r'@@ -(\d+),\d+ \+(\d+),\d+ @@').firstMatch(line);
      if (match != null) {
        oldLineNumber = int.parse(match.group(1)!) - 1;
        newLineNumber = int.parse(match.group(2)!) - 1;
      }
      return _buildHeaderLine(line);
    } else {
      updateLineNumbers(true, true);
      return _buildUnchangedLine(line, oldLineNumber, newLineNumber);
    }
  }

  Widget _buildAddedLine(String line, int lineNumber) {
    return Container(
      color: Colors.green[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLineNumber(lineNumber.toString(), Colors.green.shade900),
          Expanded(
            child: Text(
              line,
              style: TextStyle(
                color: Colors.green.shade900,
                fontFamily: "Courier",
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeletedLine(String line, int lineNumber) {
    return Container(
      color: Colors.red[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLineNumber(lineNumber.toString(), Colors.red.shade900),
          Expanded(
            child: Text(
              line,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.red.shade900,
                fontFamily: "Courier",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUnchangedLine(
      String line, int oldLineNumber, int newLineNumber) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLineNumber(oldLineNumber.toString(), Colors.grey),
        _buildLineNumber(newLineNumber.toString(), Colors.grey),
        Expanded(
          child: Text(
            line,
            style:
                TextStyle(fontFamily: "Courier", fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderLine(String line) {
    return Container(
      color: Colors.grey[300],
      child: Text(
        line,
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: "Courier"),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildLineNumber(String lineNumber, Color color) {
    return Container(
      width: 40,
      padding: const EdgeInsets.only(right: 4),
      child: Text(
        lineNumber,
        textAlign: TextAlign.right,
        style: TextStyle(
            color: color, fontFamily: "Courier", fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
