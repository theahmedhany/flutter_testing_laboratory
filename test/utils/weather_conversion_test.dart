import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/weather_display.dart';

void main() {
  group('Temperature Conversion Tests', () {
    test('celsiusToFahrenheit converts 0°C to 32°F', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.celsiusToFahrenheit(0), 32);
    });

    test('celsiusToFahrenheit converts 100°C to 212°F', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.celsiusToFahrenheit(100), 212);
    });

    test('celsiusToFahrenheit converts 25°C to 77°F', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.celsiusToFahrenheit(25), 77);
    });

    test('celsiusToFahrenheit converts -40°C to -40°F', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.celsiusToFahrenheit(-40), -40);
    });

    test('celsiusToFahrenheit converts negative temperatures correctly', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.celsiusToFahrenheit(-10), closeTo(14, 0.01));
    });

    test('fahrenheitToCelsius converts 32°F to 0°C', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.fahrenheitToCelsius(32), closeTo(0, 0.01));
    });

    test('fahrenheitToCelsius converts 212°F to 100°C', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.fahrenheitToCelsius(212), closeTo(100, 0.01));
    });

    test('fahrenheitToCelsius converts 77°F to 25°C', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.fahrenheitToCelsius(77), closeTo(25, 0.01));
    });

    test('fahrenheitToCelsius converts -40°F to -40°C', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      expect(weatherState.fahrenheitToCelsius(-40), closeTo(-40, 0.01));
    });

    test('temperature conversions are reversible', () {
      final weatherState = _WeatherDisplayStateTestHelper();
      final testTemperatures = [0, 10, 25, 37, 100, -10, -40];

      for (final temp in testTemperatures) {
        final fahrenheit = weatherState.celsiusToFahrenheit(temp.toDouble());
        final backToCelsius = weatherState.fahrenheitToCelsius(fahrenheit);
        expect(backToCelsius, closeTo(temp, 0.01));
      }
    });
  });

  group('WeatherData.fromJson Tests', () {
    test('creates WeatherData from complete JSON', () {
      final json = {
        'city': 'New York',
        'temperature': 22.5,
        'description': 'Sunny',
        'humidity': 65,
        'windSpeed': 12.3,
        'icon': '☀️',
      };

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'New York');
      expect(weatherData.temperatureCelsius, 22.5);
      expect(weatherData.description, 'Sunny');
      expect(weatherData.humidity, 65);
      expect(weatherData.windSpeed, 12.3);
      expect(weatherData.icon, '☀️');
    });

    test('creates WeatherData with default values for optional fields', () {
      final json = {'city': 'Test City', 'temperature': 20.0};

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'Test City');
      expect(weatherData.temperatureCelsius, 20.0);
      expect(weatherData.description, 'No description');
      expect(weatherData.humidity, 0);
      expect(weatherData.windSpeed, 0.0);
      expect(weatherData.icon, '🌤️');
    });

    test('throws ArgumentError when JSON is null', () {
      expect(
        () => WeatherData.fromJson(null),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Weather data cannot be null',
          ),
        ),
      );
    });

    test('throws ArgumentError when city is missing', () {
      final json = {'temperature': 20.0, 'description': 'Sunny'};

      expect(
        () => WeatherData.fromJson(json),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'City is required',
          ),
        ),
      );
    });

    test('throws ArgumentError when city is null', () {
      final json = {'city': null, 'temperature': 20.0};

      expect(
        () => WeatherData.fromJson(json),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'City is required',
          ),
        ),
      );
    });

    test('throws ArgumentError when temperature is missing', () {
      final json = {'city': 'Test City', 'description': 'Sunny'};

      expect(
        () => WeatherData.fromJson(json),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Temperature is required',
          ),
        ),
      );
    });

    test('throws ArgumentError when temperature is null', () {
      final json = {'city': 'Test City', 'temperature': null};

      expect(
        () => WeatherData.fromJson(json),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Temperature is required',
          ),
        ),
      );
    });

    test('handles integer temperature values', () {
      final json = {'city': 'Test City', 'temperature': 25};

      final weatherData = WeatherData.fromJson(json);
      expect(weatherData.temperatureCelsius, 25.0);
    });

    test('handles integer windSpeed values', () {
      final json = {'city': 'Test City', 'temperature': 25, 'windSpeed': 10};

      final weatherData = WeatherData.fromJson(json);
      expect(weatherData.windSpeed, 10.0);
    });

    test('handles partial data correctly', () {
      final json = {
        'city': 'Partial City',
        'temperature': 18.5,
        'description': 'Cloudy',
      };

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'Partial City');
      expect(weatherData.temperatureCelsius, 18.5);
      expect(weatherData.description, 'Cloudy');
      expect(weatherData.humidity, 0);
      expect(weatherData.windSpeed, 0.0);
      expect(weatherData.icon, '🌤️');
    });

    test('handles all optional fields as null', () {
      final json = {
        'city': 'Minimal City',
        'temperature': 15.0,
        'description': null,
        'humidity': null,
        'windSpeed': null,
        'icon': null,
      };

      final weatherData = WeatherData.fromJson(json);

      expect(weatherData.city, 'Minimal City');
      expect(weatherData.temperatureCelsius, 15.0);
      expect(weatherData.description, 'No description');
      expect(weatherData.humidity, 0);
      expect(weatherData.windSpeed, 0.0);
      expect(weatherData.icon, '🌤️');
    });
  });
}

class _WeatherDisplayStateTestHelper {
  double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }
}
