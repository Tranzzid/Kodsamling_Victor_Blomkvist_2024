import json

dict = {"regnr": "wer234", "brand": "Volvo", "årtal": "1989"}

with open("sump_json.json", "w", encoding="utf-8") as json_obj:
    json.dump(dict, json_obj, ensure_ascii= False, indent = 4)