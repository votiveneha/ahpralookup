FROM python:3.11-slim

# System dependencies
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
    libasound2 \
    fonts-liberation \
    libappindicator3-1 \
    xdg-utils \
    libu2f-udev \
    && rm -rf /var/lib/apt/lists/*

# Install Chrome
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y google-chrome-stable

# Install ChromeDriver matching version
RUN CHROME_VERSION=$(google-chrome --version | grep -oP "\d+\.\d+\.\d+") && \
    DRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") && \
    wget -q "https://chromedriver.storage.googleapis.com/${DRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip chromedriver_linux64.zip && \
    mv chromedriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/chromedriver && \
    rm chromedriver_linux64.zip

# Install Python deps
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Add project files
COPY main.py .

# Run app with full logging
CMD ["sh", "-c", "python3 main.py 2>&1 | tee /proc/1/fd/1"]
