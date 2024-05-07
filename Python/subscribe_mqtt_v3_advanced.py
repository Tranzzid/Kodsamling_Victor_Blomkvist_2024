# file: subscribe_hajo66_mqtt_v3_advanced.py
import sys
import datetime
import base64
import paho.mqtt.client as mqtt
import json

THE_BROKER = "eu1.cloud.thethings.network"
MY_TOPICS = 'v3/+/devices/+/up'
APP_ID = 'tranzzid-app'
API_KEY = "NNSXS.MPQZBB25DGJXN3Q4VZGEWI3OCELLFYFRRT42N5Q.DIUMBQ23QGTKOGH6XYMYS25OBLZWORSUV3ESWCD37V2UAM67FYBA"

def format_time():
    tm = datetime.datetime.now()
    sf = tm.strftime('%Y-%m-%d %H:%M:%S.%f')
    return sf[:-4]

def on_connect(client, userdata, flags, rc):
    print(f'[+] Connected to: {client._host}, port: {client._port}')
    print(f'Flags: {flags},  return code: {rc}')
    client.subscribe(MY_TOPICS, qos=0)        # Subscribe to all topics

def on_subscribe(mosq, obj, mid, granted_qos):
    print(f'Subscribed to topics: {MY_TOPICS}')
    print('Waiting for messages...')

def on_message(client, userdata, msg):
    themsg = str(msg.payload.decode("utf-8"))
    themsg = json.loads(themsg)
    payload = themsg['uplink_message']['frm_payload']
    payload_bytes = base64.b64decode(payload)
    print("Decoded:", payload_bytes)
    decoded_message = payload_bytes.decode('ascii')
    print("ASCII decoded:", decoded_message)
    #print(f'\nReceived topic: {str(msg.topic)} with payload: {themsg}, at subscribers local time: {format_time()}')

def on_disconnect():
    print("disconnect")
    client.disconnect()

client = mqtt.Client()

client.on_connect = on_connect
client.on_message = on_message
client.on_subscribe = on_subscribe
client.on_disconnect = on_disconnect

print(f'Connecting to TTN V3: {THE_BROKER}')
# Setup authentication from settings above
client.username_pw_set(APP_ID, API_KEY)

try:
    # IMPORTANT - this enables the encryption of messages
    client.tls_set()	# default certification authority of the local system
    client.connect(THE_BROKER, port=8883, keepalive=60)

except BaseException as ex:
    print(f'Cannot connect to TTN V3: {THE_BROKER}')
    print(f"TTN V3 error: {ex}")
    sys.exit()

client.loop_forever()
