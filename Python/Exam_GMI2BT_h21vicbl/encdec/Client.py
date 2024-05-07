import requests, json, sys

if len(sys.argv) == 2 and sys.argv[1] == "reverse" :
    encryption = input("Vilket ord vill du göra reverse på? ")
    response = requests.get("http://127.0.0.1:5000/reverse", json=encryption)
elif len(sys.argv) == 2 and sys.argv[1] == "ceasar":
    encryption = input("Vilket ord vill du göra ceasarcipher på? ")
    response = requests.get("http://127.0.0.1:5000/ceasar", json=encryption)
elif len(sys.argv) == 2 and sys.argv[1] == "rovar":
    encryption = input("Vilket ord vill du göra rövarspråk av? ")
    response = requests.get("http://127.0.0.1:5000/rovar", json=encryption)
else:
    encryption = "reverse"
    response = requests.get("http://127.0.0.1:5000/reverse", json=encryption)

#response = requests.get("http://127.0.0.1:5000/", json=encryption)

result = json.loads(response.content.decode("utf-8"))

for k, v in result.items():
    print(f"{k} : {v}")