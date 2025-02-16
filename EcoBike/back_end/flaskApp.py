from flask import Flask, jsonify
import threading
import vidAI

app = Flask(__name__)

def run_pipeline():
    vidAI.start_pipeline()

thread = threading.Thread(target=run_pipeline, daemon=True)
thread.start()

@app.route('/api/data', methods=['GET'])
def get_data():
    print("received get")
    # data = vidAI.prediction
    data = {'message' : 'hello'}
    return jsonify({'predictions': vidAI.prediction })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')