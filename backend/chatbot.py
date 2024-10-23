import os
from flask import Flask, request, jsonify
from langchain.document_loaders import TextLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain.embeddings import HuggingFaceEmbeddings
from langchain.vectorstores import Chroma
from langchain.chains import RetrievalQA
from langchain_huggingface import HuggingFaceEndpoint
import re
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart

app = Flask(__name__)

# Load environment variables
os.environ["HUGGINGFACEHUB_API_TOKEN"] = "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"

# Load the document
loader = TextLoader("restructured-tng-data.txt")
documents = loader.load()

# Split the document into chunks
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
texts = text_splitter.split_documents(documents)

# Create embeddings
embeddings = HuggingFaceEmbeddings()

# Create a vector store
db = Chroma.from_documents(texts, embeddings)

# Initialize the Hugging Face model
llm = HuggingFaceEndpoint(
    repo_id="mistralai/Mistral-Nemo-Instruct-2407",
    task="text-generation",
    max_new_tokens=512,
    do_sample=False,
    repetition_penalty=1.03
)

# Create a retrieval chain
qa_chain = RetrievalQA.from_chain_type(
    llm=llm,
    chain_type="stuff",
    retriever=db.as_retriever(),
    return_source_documents=True
)

def is_valid_email(email):
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None

def is_valid_mobile(mobile):
    pattern = r'^\+?1?\d{9,15}$'
    return re.match(pattern, mobile) is not None

def send_email(subject, body):
    sender_email = "tngincapp@gmail.com"
    sender_password = "cxrvfltrinkzbllu"
    receiver_email = "gouthamkallem11@gmail.com"

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject

    message.attach(MIMEText(body, "plain"))

    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
        server.login(sender_email, sender_password)
        server.send_message(message)

def needs_more_info(response):
    keywords = ["don't have enough information",
                "cannot answer",
                "insufficient information",
                "need more details",
                "No information",
                "I'm sorry",
                "I don't have enough context",
                "I don't know"
            ]
    return any(keyword.lower() in response.lower() for keyword in keywords)

@app.route('/')
def hello_world():
    return 'Hello from Flask!'

@app.route('/chatbot', methods=['POST'])
def chatbot_request():
    try:
        data = request.json
        query = data.get('text')

        if not query:
            return jsonify({"error": "Missing text"}), 400

        response = qa_chain({"query": query})

        if needs_more_info(response["result"]):
            # Collect patient information
            patient_info = collect_patient_info(data)
            
            # Send email with patient information
            subject = "New Patient Query"
            body = f"Patient Information:\n\n" \
                   f"Full Name: {patient_info['full_name']}\n" \
                   f"Email: {patient_info['email']}\n" \
                   f"Mobile: {patient_info['mobile']}\n" \
                   f"Query: {patient_info['query']}"
            send_email(subject, body)

            return jsonify({
                "text": "Thank you for providing your information. A healthcare professional will review your query and get back to you soon.",
                "collect_info": True
            })
        else:
            return jsonify({
                "text": response["result"],
                "collect_info": False
            })

    except Exception as e:
        app.logger.error(f"Error in chatbot_request: {str(e)}")
        return jsonify({"error": "An internal error occurred"}), 500

def collect_patient_info(data):
    # This function simulates collecting patient info
    # In a real scenario, you'd implement this as separate API endpoints or a multi-step process
    return {
        "full_name": data.get('full_name', "Not provided"),
        "email": data.get('email', "Not provided"),
        "mobile": data.get('mobile', "Not provided"),
        "query": data.get('text', "Not provided")
    }

if __name__ == '__main__':
    app.run(debug=True)