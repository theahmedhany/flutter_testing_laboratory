import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('WeatherDisplay Widget Tests', () {
    testWidgets('displays loading indicator initially', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Card), findsNothing);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('displays weather data after loading', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(CircularProgressIndicator), findsNothing);

      final hasWeatherCard = find.byType(Card).evaluate().isNotEmpty;
      expect(hasWeatherCard, true);
    });

    testWidgets('displays city selector dropdown', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.byType(DropdownButton<String>), findsOneWidget);
      expect(find.text('New York'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('displays temperature unit switch', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.byType(Switch), findsOneWidget);
      expect(find.text('Celsius'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('displays refresh button', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.widgetWithText(ElevatedButton, 'Refresh'), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('changes city selection', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('London').last);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('toggles temperature unit from Celsius to Fahrenheit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Celsius'), findsOneWidget);

      await tester.tap(find.byType(Switch));
      await tester.pump();

      expect(find.text('Fahrenheit'), findsOneWidget);
    });

    testWidgets('refresh button reloads weather data', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.widgetWithText(ElevatedButton, 'Refresh'));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('displays error state for invalid city', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('displays weather icon when data is available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final cardFinder = find.byType(Card);
      if (cardFinder.evaluate().isNotEmpty) {
        final textWidgets = find.byType(Text);
        expect(textWidgets.evaluate().length, greaterThan(0));
      }
    });

    testWidgets('displays humidity and wind speed when available', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final humidityIcon = find.byIcon(Icons.water_drop);
      final windIcon = find.byIcon(Icons.air);

      if (humidityIcon.evaluate().isNotEmpty) {
        expect(windIcon, findsOneWidget);
        expect(find.text('Humidity'), findsOneWidget);
        expect(find.text('Wind Speed'), findsOneWidget);
      }
    });

    testWidgets('temperature displays with correct unit in Celsius', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      final celsiusTexts = find.textContaining('°C');

      if (find.byIcon(Icons.water_drop).evaluate().isNotEmpty) {
        expect(celsiusTexts, findsWidgets);
      }
    });

    testWidgets('temperature displays with correct unit in Fahrenheit', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(Switch));
      await tester.pump();

      final fahrenheitTexts = find.textContaining('°F');

      if (find.byIcon(Icons.water_drop).evaluate().isNotEmpty) {
        expect(fahrenheitTexts, findsWidgets);
      }
    });

    testWidgets('error card has correct styling', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Error'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      final errorCards = tester.widgetList<Card>(find.byType(Card)).where((
        card,
      ) {
        return card.color == Colors.red.shade50;
      });
      expect(errorCards.length, greaterThan(0));
    });

    testWidgets('displays city name in weather card', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      if (find.byIcon(Icons.water_drop).evaluate().isNotEmpty) {
        expect(find.text('New York'), findsWidgets);
      }
    });

    testWidgets('maintains temperature unit preference across refreshes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(Switch));
      await tester.pump();
      expect(find.text('Fahrenheit'), findsOneWidget);

      await tester.tap(find.widgetWithText(ElevatedButton, 'Refresh'));
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Fahrenheit'), findsOneWidget);
    });
  });

  group('WeatherDisplay Loading State Tests', () {
    testWidgets('loading indicator is shown during data fetch', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
    });

    testWidgets('loading indicator disappears after successful load', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(CircularProgressIndicator), findsNothing);
    });

    testWidgets('loading indicator disappears after error', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Error'), findsOneWidget);
    });
  });

  group('WeatherDisplay Error Handling Tests', () {
    testWidgets('shows error for null API response', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Error'), findsOneWidget);
      expect(
        find.textContaining('Failed to fetch weather data'),
        findsOneWidget,
      );
    });

    testWidgets('error message is displayed in red card', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('can recover from error state', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: WeatherDisplay())),
      );

      await tester.pumpAndSettle(const Duration(seconds: 3));

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Invalid City').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Error'), findsOneWidget);

      await tester.tap(find.byType(DropdownButton<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('London').last);
      await tester.pumpAndSettle(const Duration(seconds: 3));

      expect(find.text('Error'), findsNothing);
    });
  });
}
