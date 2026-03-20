FROM node:18

# Puppeteer için gerekli sistem bağımlılıklarını yükle
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    ca-certificates \
    procps \
    libnss3 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./

# Puppeteer ile birlikte Chrome'u da indir
RUN npm install
RUN npx puppeteer browsers install chrome

COPY . .

# Render için Puppeteer önbellek yolunu ayarla
ENV PUPPETEER_CACHE_DIR=/opt/render/.cache/puppeteer

CMD ["node", "index.js"]
