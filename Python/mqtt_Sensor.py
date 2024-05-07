import paho.mqtt.client as mqtt
import time
def on_message(client, userdata, msg):
    print("message received = ", {str(msg.payload)})
    print("message topic = ", msg.topic)
    print("message qos = ", msg.qos)
    print("message retain flag = ", msg.retain)
    
    time.sleep(3)
    client.publish("testtopic/Tranzzid", "Hello from mqtt_Sensor.py")

THE_BROKER = 'broker.hivemq.com'

client =mqtt.Client("Tranzzid's MQTT Client")

client.on_message = on_message

client.connect(THE_BROKER)

#client.loop_start()

client.subscribe("testtopic/Tranzzid_2")

client.publish("testtopic/Tranzzid", "Hello from mqtt_Sensor.py")

#time.sleep(4)

client.loop_forever(3)
