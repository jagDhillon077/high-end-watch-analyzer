# High-End Watch Analyzer

## Overview

This project demonstrates a comprehensive solution that integrates frontend, backend, cloud + devops, and AI/ML components. It is designed to analyze high-end watch images and classify them according to their brands using machine learning techniques.

## Project Structure

- **Frontend (UI)**: 
  - The `ui` directory contains the frontend components built with modern web technologies, providing an interactive interface for users to upload images and view classification results.
  
- **Backend**:
  - The `server` directory hosts the backend services responsible for handling API requests, processing data, and interacting with the machine learning model. The backend is implemented in Python using Flask, ensuring scalability and ease of deployment.

- **Cloud + DevOps**:
  - The project is designed with cloud deployment in mind, allowing it to be hosted on cloud platforms like AWS, Azure, or Google Cloud. DevOps practices such as continuous integration/continuous deployment (CI/CD) can be integrated to ensure smooth updates and maintenance.

- **AI + ML**:
  - The core of the project lies in its machine learning model, which is trained to classify images of high-end watches. The `notebooks` directory contains Jupyter notebooks detailing the model training process. While the classifier model file (`classifier.pkl`) is not included due to its size, it is essential for running the complete system.

## Features

1. **Image Classification**: 
   - The system can classify images of various luxury watch brands, including Rolex, Omega, Cartier, and more.

2. **Scraping and Data Collection**: 
   - The `scraper` directory contains Ruby scripts that were used to scrape images and data from various sources, which were then used to train the machine learning model.

3. **Interactive UI**: 
   - A user-friendly interface allows users to upload images and receive classification results in real-time.

## Installation and Setup

1. **Frontend**:
   - Navigate to the `ui` directory and run the following commands to install dependencies and start the development server:
     ```bash
     npm install
     npm start
     ```

2. **Backend**:
   - Navigate to the `server` directory and set up the Python environment:
     ```bash
     pip install -r requirements.txt
     python server.py
     ```

3. **Model**:
   - The model is placed in the `models` directory. It is under the name `classifier.pkl`

4. **Deployment**:
   - The project is cloud-ready and can be deployed using Docker or directly on cloud services like AWS, Azure, or Google Cloud. Ensure that all environment variables are correctly set up for production deployment.

## Usage

1. Start both the frontend and backend servers.
2. Access the UI via your web browser.
3. Upload an image of a high-end watch to receive a brand classification.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for any suggestions or improvements.
