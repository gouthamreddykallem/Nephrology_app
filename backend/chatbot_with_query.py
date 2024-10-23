# chatbot.py

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
import logging

app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Load environment variables
os.environ["HUGGINGFACEHUB_API_TOKEN"] = "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"

# Initialize Langchain components
try:
    loader = TextLoader("restructured-tng-data.txt")
    documents = loader.load()
    text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
    texts = text_splitter.split_documents(documents)
    embeddings = HuggingFaceEmbeddings()
    db = Chroma.from_documents(texts, embeddings)
    llm = HuggingFaceEndpoint(
        repo_id="mistralai/Mistral-Nemo-Instruct-2407",
        task="text-generation",
        max_new_tokens=512,
        do_sample=False,
        repetition_penalty=1.03
    )
    qa_chain = RetrievalQA.from_chain_type(
        llm=llm,
        chain_type="stuff",
        retriever=db.as_retriever(),
        return_source_documents=True
    )
except Exception as e:
    logger.error(f"Error initializing components: {str(e)}")
    raise

def is_valid_email(email):
    pattern = r'^[\w\.-]+@[\w\.-]+\.\w+$'
    return re.match(pattern, email) is not None

def is_valid_mobile(mobile):
    pattern = r'^\+?1?\d{9,15}$'
    return re.match(pattern, mobile) is not None

def needs_more_info(response):
    keywords = [
        "don't have enough information",
        "cannot answer",
        "insufficient information",
        "need more details",
        "No information",
        "I'm sorry",
        "I don't have enough context",
        "I don't know"
    ]
    return any(keyword.lower() in response.lower() for keyword in keywords)

def send_email(subject, body_data):
    sender_email = "tngincapp@gmail.com"
    sender_password = "cxrvfltrinkzbllu"
    receiver_email = "gouthamkallem11@gmail.com"

    message = MIMEMultipart('alternative')
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject

    # Create HTML version of the email with improved styling
    html_content = f"""
    <html>
        <head>
            <style>
                body {{
                    font-family: Arial, sans-serif;
                    line-height: 1.6;
                    color: #333333;
                    margin: 0;
                    padding: 20px;
                }}
                .container {{
                    max-width: 600px;
                    margin: 0 auto;
                    background-color: #ffffff;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 2px 4px rgba(0,0,0,0.1);
                }}
                .header {{
                    background-color: #1C4D85;
                    color: white;
                    padding: 20px;
                    border-radius: 8px 8px 0 0;
                    margin: -20px -20px 20px -20px;
                }}
                .section {{
                    margin: 20px 0;
                    padding: 20px;
                    background-color: #f9f9f9;
                    border-radius: 5px;
                }}
                .section-title {{
                    color: #1C4D85;
                    font-size: 18px;
                    font-weight: bold;
                    border-bottom: 2px solid #1C4D85;
                    padding-bottom: 8px;
                    margin-bottom: 15px;
                }}
                .field {{
                    margin: 10px 0;
                    padding: 8px;
                    background-color: #ffffff;
                    border-radius: 4px;
                }}
                .label {{
                    font-weight: bold;
                    color: #555555;
                    min-width: 120px;
                    display: inline-block;
                }}
                .query-section {{
                    background-color: #ffffff;
                    border-left: 4px solid #1C4D85;
                    padding: 15px;
                    margin-top: 10px;
                    line-height: 1.8;
                }}
                .footer {{
                    margin-top: 20px;
                    padding-top: 20px;
                    border-top: 1px solid #eee;
                    font-size: 12px;
                    color: #666;
                    text-align: center;
                }}
            </style>
        </head>
        <body>
            <div class="container">
                <div class="header">
                    <h2 style="margin:0;">New Patient Query</h2>
                </div>
                <div class="section">
                    <div class="section-title">Patient Information</div>
                    <div class="field">
                        <span class="label">Full Name:</span> {body_data['full_name']}
                    </div>
                    <div class="field">
                        <span class="label">Email:</span> {body_data['email']}
                    </div>
                    <div class="field">
                        <span class="label">Mobile:</span> {body_data['mobile']}
                    </div>
                </div>
                <div class="section">
                    <div class="section-title">Query/Message</div>
                    <div class="query-section">
                        {body_data['text'].replace('\n', '<br>')}
                    </div>
                </div>
                <div class="footer">
                    This is an automated message from the TNG Patient Portal
                </div>
            </div>
        </body>
    </html>
    """

    # Create plain text version as fallback
    text_content = f"""
    Patient Information
    ------------------
    Full Name: {body_data['full_name']}
    Email: {body_data['email']}
    Mobile: {body_data['mobile']}

    Query/Message
    ------------
    {body_data['text']}
    """

    # Attach both versions
    message.attach(MIMEText(text_content, 'plain'))
    message.attach(MIMEText(html_content, 'html'))

    try:
        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
            server.login(sender_email, sender_password)
            server.send_message(message)
        logger.info(f"Email sent successfully for {body_data['full_name']}")
        return True
    except Exception as e:
        logger.error(f"Error sending email: {str(e)}")
        return False

@app.route('/chatbot', methods=['POST'])
def chatbot_request():
    try:
        data = request.json
        logger.info(f"Received request: {data}")
        
        query = data.get('text')
        if not query:
            return jsonify({"error": "Missing text"}), 400

        # Check if this is a follow-up with patient information
        has_patient_info = all(key in data for key in ['full_name', 'email', 'mobile'])
        is_followup = data.get('is_followup', False)

        # Validate patient information if present
        if has_patient_info:
            if not is_valid_email(data['email']):
                return jsonify({"error": "Invalid email format"}), 400
            if not is_valid_mobile(data['mobile']):
                return jsonify({"error": "Invalid mobile number format"}), 400

        # If this is a follow-up with patient info
        if has_patient_info and is_followup:
            logger.info(f"Processing follow-up request for {data['full_name']}")
            subject = "New Patient Query"
            email_sent = send_email(subject, data)
            
            if email_sent:
                return jsonify({
                    "text": "Thank you for providing your information. A healthcare professional will review your query and get back to you soon.",
                    "collect_info": False
                })
            else:
                logger.error("Failed to send email")
                return jsonify({
                    "text": "We're experiencing technical difficulties. Please try again later or contact us directly.",
                    "collect_info": False
                }), 500

        # Regular query processing
        logger.info(f"Processing regular query: {query}")
        response = qa_chain({"query": query})

        if needs_more_info(response["result"]):
            return jsonify({ 
                "text": "To better assist you with your query, we'll need some additional information.",
                "collect_info": True
            })
        else:
            return jsonify({
                "text": response["result"],
                "collect_info": False
            })

    except Exception as e:
        logger.error(f"Error in chatbot_request: {str(e)}")
        return jsonify({
            "error": "An internal error occurred",
            "details": str(e)
        }), 500

if __name__ == '__main__':
    app.run(debug=True)