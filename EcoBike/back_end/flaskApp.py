from flask import Flask, jsonify
from statistics import mode
import threading
import vidAI

app = Flask(__name__)

def run_pipeline():
    vidAI.start_pipeline()

thread = threading.Thread(target=run_pipeline, daemon=True)
thread.start()

prev10FrameCount = [0]
 #{'image': {'width': 1920, 'height': 1080}, 'predictions': [{'x': 1574.5, 'y': 803.0, 'width': 685.0, 'height': 552.0, 'confidence': 0.48679766058921814, 'class': 'Plastic', 'class_id': 7, 'detection_id': 'd213a09f-e74a-4351-b45f-6815b71cbe74'}]}

@app.route('/api/data', methods=['GET'])
def get_data():
    print("received get")
    # data = vidAI.prediction
    # data = {'message' : 'hello'}

    count = len(vidAI.prediction)
    framesMode = mode(prev10FrameCount)
    print(prev10FrameCount)
    prev10FrameCount.append(count)
    if len(prev10FrameCount) >= 10:
        prev10FrameCount.pop(0)



    return jsonify({'predictions': framesMode })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)