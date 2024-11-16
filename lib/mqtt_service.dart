// mqtt_service.dart
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final client = MqttServerClient('mqtt.yourbroker.com', 'flutter_client');

  MqttService() {
    client.port = 1883; // Or the port your MQTT broker uses
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.logging(on: true);
  }

  Future<void> connect() async {
    client.connectionMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .withWillTopic('willtopic') // Set if you need a last will message
        .startClean();

    try {
      await client.connect();
      print('Connected to MQTT broker.');
    } catch (e) {
      print('Error: $e');
      disconnect();
    }
  }

  void disconnect() {
    client.disconnect();
    print('Disconnected from MQTT broker.');
  }

  void onDisconnected() {
    print('Client disconnected');
  }

  void subscribe(String topic, Function(String) onMessage) {
    client.subscribe(topic, MqttQos.atMostOnce);
    client.updates?.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final payload = MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

      onMessage(payload);
    });
  }
}
