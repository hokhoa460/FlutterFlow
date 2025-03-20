// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fl_chart/fl_chart.dart'; // Importing the 'fl_chart' package for charting and graphing.
import 'package:web_socket_channel/web_socket_channel.dart'; // Importing WebSocket package to enable real-time communication.

class DistractedDrivingGraph extends StatefulWidget {
  final WebSocketChannel
      channel; // Define a WebSocketChannel that will be passed into the widget for real-time data.

  // Constructor to receive the WebSocketChannel as an argument.
  DistractedDrivingGraph({required this.channel});

  @override
  _DistractedDrivingGraphState createState() =>
      _DistractedDrivingGraphState(); // Create state for the widget.
}

class _DistractedDrivingGraphState extends State<DistractedDrivingGraph> {
  // List to store the number of incidents per day for the past week (7 days).
  List<int> incidentsPerDay = List.generate(
      7, (index) => 0); // Initialize a list of 7 integers, all set to 0.

  @override
  void initState() {
    super.initState(); // Initialize the state.

    // Set up a listener to handle real-time data updates coming from the microcontroller via WebSocket.
    widget.channel.stream.listen((data) {
      // Convert the incoming data to an integer (incident count).
      final incidentCount = int.tryParse(data);

      // If the data could be parsed into an integer (i.e., valid incident count), update the graph.
      if (incidentCount != null) {
        setState(() {
          // Shift the data by removing the oldest value (index 0) and adding the new incident count to the end.
          incidentsPerDay
              .removeAt(0); // Remove the first element (oldest data).
          incidentsPerDay.add(
              incidentCount); // Add the new incident count to the end of the list.
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build the widget's UI.
    return Padding(
      padding: const EdgeInsets.all(16.0), // Add padding around the chart.
      child: LineChart(
        // Define the data and appearance of the line chart.
        LineChartData(
          gridData: FlGridData(show: true), // Display grid lines on the chart.
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
                showTitles: true), // Show titles on the left axis (Y-axis).
            bottomTitles: SideTitles(
                showTitles: true), // Show titles on the bottom axis (X-axis).
          ),
          borderData:
              FlBorderData(show: true), // Show borders around the chart.
          lineBarsData: [
            LineChartBarData(
              // Create a list of chart points (FlSpot) from the incidentsPerDay list.
              spots: incidentsPerDay.asMap().entries.map((entry) {
                int idx = entry
                    .key; // Get the index of the list entry (X-axis position).
                int value = entry
                    .value; // Get the value of incidents for the current day (Y-axis position).
                return FlSpot(idx.toDouble(),
                    value.toDouble()); // Create a FlSpot for each data point.
              }).toList(),
              isCurved: true, // Make the line in the chart curved (smooth).
              colors: [Colors.blue], // Set the line color to blue.
              dotData: FlDotData(
                  show: false), // Do not show dots on the chart points.
              belowBarData: BarAreaData(
                  show: false), // Do not display the area under the line.
            ),
          ],
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
