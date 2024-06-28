from flask import Flask, request, jsonify
from flask_cors import CORS
import pickle
import nltk
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords

app = Flask(__name__)
CORS(app)  # This will enable CORS for all routes

# Load the model
with open('chatbot_model.pkl', 'rb') as f:
    model = pickle.load(f)

# Load responses
with open('responses.pkl', 'rb') as f:
    responses = pickle.load(f)

nltk.download('punkt')
nltk.download('stopwords')

def preprocess(text):
    tokens = word_tokenize(text.lower())
    return ' '.join([t for t in tokens if t not in stopwords.words('english')])

@app.route('/chat', methods=['POST'])
def chat():
    data = request.json
    user_message = data.get('message', '')
    
    if not user_message:
        return jsonify({'error': 'No message provided'}), 400

    preprocessed_input = preprocess(user_message)
    probabilities = model.predict_proba([preprocessed_input])[0]
    max_probability = max(probabilities)
    
    if max_probability < 0.002:
        bot_response = "I'm not sure how to answer that. An agent is working on it and will get back as soon as possible"
    else:
        response_idx = probabilities.argmax()
        bot_response = responses[response_idx]
    
    return jsonify({
        'response': bot_response,
        'confidence': float(max_probability)
    })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
