from PIL import Image
from flask import Flask, request
from flask_cors import CORS
from fastai.vision.all import load_learner
from scipy.special import SpecialFunctionWarning, SpecialFunctionError
app = Flask(__name__) 
CORS(app)

file = "../models/classifier.pkl"

# Load the model and optimizer state (if available) onto the CPU
CLASSIFIER = load_learner(file)

BRANDS = [
    'rolex',
    'audemarspiguet',
    'breitling',
    'iwc',
    'jaegerlecoultre',
    'omega',
    'panerai',
    'patekphilippe',
    'cartier',
    'gucci',
    'seiko',
    'movado',
    'zenith'
]


@app.route("/classify", methods=["POST", "OPTIONS"])
def classify():
    image = Image.open(request.files["image"])
    image.load()
    new_width = 480
    new_height = 480
    resized_image = image.resize((new_width, new_height))
    predictions = CLASSIFIER.predict(resized_image)
    print(predictions)
    BRANDS.remove(predictions[0])
    BRANDS.insert(0, predictions[0])
    PERCENTAGES = [round(x, 4) for x
                   in map(float, sorted(predictions[2], reverse=True))]
    return {
        "brandPredictions": list(zip(
            BRANDS,
            PERCENTAGES
        ))
    }


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
