# Import the InferencePipeline object
from inference import InferencePipeline
# Import the built in render_boxes sink for visualizing results
from inference.core.interfaces.stream.sinks import render_boxes

prediction = []

def handle_predictions(info, videoFrames):
    # print(info)
    global prediction
    prediction = info['predictions']
    for p in info['predictions']:
        print(f"Litter detected: {p['class']}")  # Assuming 'class' holds the litter type
    render_boxes(info, video_frame=videoFrames)


def start_pipeline():
    # initialize a pipeline object
    pipeline = InferencePipeline.init(
        # model_id="litter-detection-model-re3aa/4", # Roboflow model to use
        model_id="trash-ai-v2/1",
        video_reference="rtsp://192.168.225.130:8080/h264_ulaw.sdp", # Path to video, device id (int, usually 0 for built in webcams), or RTSP stream url
        # Due to change
        on_prediction=handle_predictions, # Function to run after each prediction
    )
    pipeline.start()
    pipeline.join()

if __name__ == "__main__":
    start_pipeline()
