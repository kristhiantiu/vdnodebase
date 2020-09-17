FROM node:10.18

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

# Install ImageMagick v6.8
RUN apt-get update && apt-get -y install --no-install-recommends xz-utils build-essential checkinstall libx11-dev libxext-dev zlib1g-dev libjpeg-dev libfreetype6-dev libxml2-dev
WORKDIR /opt
RUN wget https://imagemagick.org/download/releases/ImageMagick-6.8.0-10.tar.xz && tar -xJf ImageMagick-6.8.0-10.tar.xz
WORKDIR /opt/ImageMagick-6.8.0-10
RUN touch configure && \
    chmod +x configure && \
    ./configure --disable-openmp && \
    make && make install && \
    ldconfig /usr/local/lib

# Install dependencies that puppeteer needs (from https://stackoverflow.com/questions/52993002/headless-chrome-node-api-and-puppeteer-installation)
RUN apt-get -y install gconf-service libasound2 libatk1.0-0 libatk-bridge2.0-0 libc6 libcairo2 libcups2 libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

# Install ghostscript and poppler
RUN apt-get -y install --no-install-recommends ghostscript libgs-dev poppler-utils

WORKDIR /home/node/app