# Use the official Rasa image as the base image
FROM rasa/rasa:latest

# Set the working directory
WORKDIR /app

# Copy the Rasa project files to the container
COPY . /app

# Install additional dependencies if required
# RUN pip install <additional-dependencies>

# Expose the port that Rasa server will run on
EXPOSE 5005

# Start the Rasa server
CMD ["run", "--enable-api", "--cors", "*"]