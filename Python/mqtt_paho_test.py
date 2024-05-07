# From https://www.eclipse.org/paho/clients/python/
import paho.mqtt.client as mqtt
import time

# test.mosquitto.org
# broker.hivemq.com
# iot.eclipse.org
THE_BROKER = 'broker.hivemq.com'
# Broker at OCI private VCN
#THE_BROKER = '10.0.0.213'
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, flags, rc):
    print(f'Connected with result code: {str(rc)}')
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    #client.subscribe("$SYS/#")
    #client.subscribe("#")
    client.subscribe("testtopic/Tranzzid")
    # listen for vm monitor data @ OCI
    #client.subscribe("OCI-monitor/#")

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):
    print(f'{msg.topic} {str(msg.payload)}')
    
    time.sleep(3)
    client.publish("testtopic/Tranzzid_2", "Hello from mqtt_paho_test.py")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message
#client.username_pw_set("username", "password")

print(f'Connecting to broker: {THE_BROKER}')
client.connect(THE_BROKER, port=1883, keepalive=60)
# Blocking call that processes network traffic, dispatches callbacks and handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a manual interface.
client.loop_forever()
