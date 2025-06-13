FROM apify/actor-python:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    gnupg \
    curl \
    xvfb \
    libxi6 \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libappindicator1 \
    libindicator7 \
    fonts-liberation \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    --no-install-recommends

# Install Chrome 116
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_116.0.5845.96-1_amd64.deb && \
    dpkg -i google-chrome-stable_116.0.5845.96-1_amd64.deb || apt-get -fy install && \
    rm google-chrome-stable_116.0.5845.96-1_amd64.deb

# Install ChromeDriver 116
RUN wget -O /tmp/chromedriver.zip https://chromedriver.storage.googleapis.com/116.0.5845.96/chromedriver_linux64.zip && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/chromedriver && \
    rm /tmp/chromedriver.zip

COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .