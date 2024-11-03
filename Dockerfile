FROM node:23-bullseye

WORKDIR /home/node/app

COPY app.js .

EXPOSE 8080

USER node

CMD ["node", "app.js"]
