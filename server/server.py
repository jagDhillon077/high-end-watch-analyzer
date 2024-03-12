from PIL import Image
from flask import Flask
import fastai.vision.all as fastai
app = Flask(__name__)

file = "./models/classifier.pkl"

# Load the model and optimizer state (if available) onto the CPU
CLASSIFIER = fastai.load_learner(file)

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


@app.route("/classify")
def classify():
    image = Image.open("gucci.jpg")
    image.load()
    predictions = CLASSIFIER.predict(image)

    BRANDS.remove(predictions[0])
    BRANDS.insert(0, predictions[0])
    PERCENTAGES = [round(x,4) for x 
                   in map(float, sorted(predictions[2], reverse=True))]
    print(predictions)
    return {
        "brandPredictions": list(zip(
            BRANDS,
            PERCENTAGES
        ))
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)



