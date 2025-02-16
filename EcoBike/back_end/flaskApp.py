from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/api/data', methods=['GET'])
def get_data():
    print("received get")
    data = {'message': 'Hello from Python backend!'}
    return jsonify(data)

if __name__ == '__main__':
    app.run(debug=True)