from ipaddress import ip_interface
import requests, json, sys

def send_ip():
    if len(sys.argv) == 2:
        ip_interface = sys.argv[1]
    elif len(sys.argv) == 3:
        ip_address = sys.argv[1]
        ip_subnet = sys.argv[2]
        ip_interface = (f"{ip_address}/{ip_subnet}")
    else:
        ip_interface = "192.168.1.1/24"
    
    response = requests.get("http://127.0.0.1:5000/", json=ip_interface)
    
    result = json.loads(response.content.decode("utf-8"))
    
    for k, v in result.items():
        print(f"{k} : {v}")

send_ip()