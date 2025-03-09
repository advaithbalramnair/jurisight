# Use an official image with Node.js and Python
FROM node:18-bullseye

# Set the working directory
WORKDIR /app

# Install required system packages
RUN apt-get update && apt-get install -y python3-pip python3-dev

# Install PyTorch separately (prebuilt binaries to avoid timeouts)
RUN pip3 install torch==2.5.1 --no-cache-dir -f https://download.pytorch.org/whl/cpu.html

# Copy requirements.txt first to leverage caching
COPY requirements.txt ./

# Install the rest of the Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy Node.js dependencies first for caching
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose necessary ports
EXPOSE 3000

# Install PM2 globally
RUN npm install -g pm2

# Start both Flask and Node.js servers using PM2
CMD ["pm2-runtime", "start", "ecosystem.config.js"]