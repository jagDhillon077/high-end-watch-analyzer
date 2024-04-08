import React, { useState } from "react";
import axios from "axios";
import "./App.css";

const API_ENDPOINT = "http://127.0.0.1:8000";
const API_CLIENT = axios.create({
  baseURL: API_ENDPOINT,
  timeout: 10000,
});

const App = () => {
  const [predictions, setPredictions] = useState({
    pricePrediction: undefined,
    brandPredictions: [],
  });
  const [imgSrc, setImgSrc] = useState("");

  const _onDragOver = (e) => {
    e.preventDefault();
  };

  const _onDragLeave = (e) => {
    e.preventDefault();
  };

  const _onDrop = (e) => {
    e.preventDefault();
    console.log("Number of dropped items:", e.dataTransfer.files.length);
    if (e.dataTransfer.items.length > 0) {
      console.log("Kind of first dropped item:", e.dataTransfer.items[0].kind);
    }
    var targetFile = e.dataTransfer.files[0];
    if (targetFile) {
      var reader = new FileReader();
      reader.readAsDataURL(targetFile);
      reader.onloadend = (e) => {
        setImgSrc(reader.result);
      };
      var data = new FormData();
      data.append("image", targetFile);
      API_CLIENT.post("/classify", data, {
        headers: { "Content-Type": targetFile.type },
      })
        .then((response) => {
          setPredictions(response.data);
        })
        .catch((error) => {
          console.log(error);
        });
    } else {
      console.log("No file was dropped");
    }
  };

  var ImagePreview;
  if (imgSrc) {
    ImagePreview = <img src={imgSrc} alt="img-of-a-watch" />;
  }

  var Predictions = [];
  predictions.brandPredictions.forEach((item, index) => {
    Predictions.push(
      <p key={`item-${index}`}>
        {item[0]}: {item[1]}
      </p>
    );
  });

  return (
    <div className="App">
      <div
        className="file-dropzone"
        onDragOver={(e) => {
          _onDragOver(e);
        }}
        onDragLeave={(e) => {
          _onDragLeave(e);
        }}
        onDrop={(e) => {
          _onDrop(e);
        }}
      >
        <div style={{ height: "210px", width: "210px" }}>{ImagePreview}</div>
      </div>

      <div className="predictions">{Predictions}</div>
    </div>
  );
};

export default App;
