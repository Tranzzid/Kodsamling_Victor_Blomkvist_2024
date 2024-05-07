import ipaddress as ip
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/")
def index():
    if __name__ == "__main__":
        jobj = request.json
        ipi = ip.ip_interface(jobj)
        
        result = {}
        result["ipaddress"] = str(ipi.ip)
        result["subnetmask"] = str(ipi.netmask)
        result["wildcardmask"] = str(ipi.network.hostmask)
        result["cidr"] = str(ipi.network.prefixlen)
        result["network"] = str(ipi.network.network_address)
        result["broadcast"] = str(ipi.network.broadcast_address)
        result["firsthost"] = str(ipi.network.network_address + 1)
        result["lasthost"] = str(ipi.network.broadcast_address - 1)
        result["numusablehosts"] = str(ipi.network.num_addresses-2)
        
        result_json = jsonify(result)
        
        return result_json

if __name__=="__main__":
    app.run(debug=True)