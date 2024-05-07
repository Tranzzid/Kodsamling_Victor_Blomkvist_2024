from flask import Flask, request, jsonify
import reverse, rovarsprak,ceasar
from myhashcalc import hashcalc

app = Flask(__name__)


@app.route("/reverse")
def index_reverse():
    if __name__ == "__main__":
        algo = 'sha1'
        
        jobj = request.json
        
        message = str(jobj)
        
        message_dict = {}
        message_dict["before"] = str(hashcalc(message.encode('ascii'), algo))
        message_dict["sending"] = str(message)
        reversed_message = str(reverse.reverse(message))
        message_dict["received"] = reversed_message
        message = str(reverse.reverse(reversed_message))
        message_dict["verifying"] = message
        message_dict["after"] = str(hashcalc(message.encode('ascii'), algo))
        
        message_json = jsonify(message_dict)
    return message_json




@app.route("/ceasar")
def index_ceasar():
    if __name__ == "__main__":
        algo = 'sha1'
        
        rot = 15
        
        jobj = request.json
        
        message = str(jobj)
        
        message_dict = {}
        message_dict["Before"] = str(hashcalc(message.encode('ascii'), algo))
        message_dict["Plain"] = str(message)
        message_dict["Shift pattern"] = str(rot)
        encrypted_message = ceasar.encrypt(message, rot)
        message_dict["Cipher"] = encrypted_message
        decrypted_message = ceasar.decrypt(encrypted_message, rot)
        message_dict["Decrypted_Plain"] = decrypted_message
        message_dict["After"] = str(hashcalc(decrypted_message.encode('ascii'), algo))
        
        message_json = jsonify(message_dict)
    return message_json



@app.route("/rovar")
def index_rovar():
    if __name__ == "__main__":
        algo = 'sha1'
        
        
        jobj = request.json
        
        message = str(jobj)
        
        message_dict = {}
        message_dict["Before"] = str(hashcalc(message.encode('ascii'), algo))
        message_dict["Sending"] = str(message)
        encrypted_rovar_message = rovarsprak.enc_rov(message)
        message_dict["Received"] = encrypted_rovar_message
        decrypted_rovar_message = rovarsprak.dec_rov(encrypted_rovar_message)
        message_dict["Verifying"] = decrypted_rovar_message
        message_dict["After"] = str(hashcalc(decrypted_rovar_message.encode('ascii'), algo))
        
        message_json = jsonify(message_dict)
    return message_json



if __name__=="__main__":
    app.run(debug=True)