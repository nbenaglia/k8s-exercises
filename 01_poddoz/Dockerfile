FROM node:7
COPY app.js /app.js
COPY package*.json ./

RUN npm install

ENTRYPOINT ["node", "app.js"]
