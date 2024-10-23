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

app = Flask(__name__)

# [Previous configurations remain the same...]

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

def send_email(subject, body):
    sender_email = "tngincapp@gmail.com"
    sender_password = "cxrvfltrinkzbllu"
    receiver_email = "gouthamkallem11@gmail.com"

    message = MIMEMultipart()
    message["From"] = sender_email
    message["To"] = receiver_email
    message["Subject"] = subject

    message.attach(MIMEText(body, "plain"))

    try:
        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
            server.login(sender_email, sender_password)
            server.send_message(message)
        return True
    except Exception as e:
        print(f"Error sending email: {str(e)}")
        return False

@app.route('/chatbot', methods=['POST'])
def chatbot_request():
    try:
        data = request.json
        query = data.get('text')
        
        if not query:
            return jsonify({"error": "Missing text"}), 400

        # Check if this is a follow-up with patient information
        has_patient_info = all(key in data for key in ['full_name', 'email', 'mobile'])

        if has_patient_info:
            # Send email with patient information
            subject = "New Patient Query"
            body = f"Patient Information:\n\n" \
                   f"Full Name: {data['full_name']}\n" \
                   f"Email: {data['email']}\n" \
                   f"Mobile: {data['mobile']}\n" \
                   f"Query: {data['text']}"
            
            email_sent = send_email(subject, body)
            
            if email_sent:
                return jsonify({
                    "text": "Thank you for providing your information. A healthcare professional will review your query and get back to you soon.",
                    "collect_info": False
                })
            else:
                return jsonify({
                    "text": "We're experiencing technical difficulties. Please try again later or contact us directly.",
                    "collect_info": False
                }), 500

        # Regular query processing
        response = qa_chain({"query": query})

        if needs_more_info(response["result"]):
            return jsonify({
                "text": "To better assist you, we'll need some additional information.",
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

if __name__ == '__main__':
    app.run(debug=True)