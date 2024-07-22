from flask import Flask, request, jsonify

app = Flask(__name__)

saved_addresses = []
default_address = None

@app.route('/addresses', methods=['POST'])
def save_address():
    address = request.json
    saved_addresses.append(address)
    return jsonify(address), 201

@app.route('/addresses', methods=['GET'])
def get_addresses():
    return jsonify(saved_addresses)

@app.route('/set-default', methods=['POST'])
def set_default_address():
    global default_address
    default_address = request.json.get('default_address')
    return jsonify({'default_address': default_address})

if __name__ == '__main__':
    app.run(debug=True)
