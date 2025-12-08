FROM node:23-alpine

ARG CODE_PATH

WORKDIR /usr/src/app

# Copy package.json first for caching
COPY "$CODE_PATH/package.json" ./

RUN npm install

# Copy source
COPY "$CODE_PATH" .

# Start app
CMD ["npm", "start"]
