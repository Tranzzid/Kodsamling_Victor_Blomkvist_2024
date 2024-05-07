import requests, json

def fetch_url(url):
    response = requests.get(url)
    data = response.text
    
    try:
        with open("test.html", "w", encoding="utf-8") as fpointer:
            fpointer.write(data)
    except FileNotFoundError as ferr:
        print(ferr)
  

def fetch_url_json(url):
    response = requests.get(url)
    data_jsonObj = response.json()
    try:
        with open("file_str.json", "w", encoding="utf-8") as fpointer:
            wdata = json.dumps(data_jsonObj)
            fpointer.write(wdata)
    except Exception as ferr:
        print(ferr)


def fetch_url_json_dump(url):
    response = requests.get(url)
    data_jsonObj = response.json()
    try:
        with open("file.json", "w", encoding="utf-8") as fpointer:
            json.dump(data_jsonObj, fpointer)
    except Exception as ferr:
        print(ferr)



      
#fetch_url("https://www.du.se/")
#fetch_url_json("https://dog.ceo/api/breeds/image/random")
fetch_url_json_dump("https://dog.ceo/api/breeds/image/random")