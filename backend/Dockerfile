FROM node:18-alpine

WORKDIR /app

# install dependencies
COPY package*.json ./
RUN npm install --production

# copy source
COPY . .

ENV NODE_ENV=production
EXPOSE 5000

CMD ["node", "app.js"]
