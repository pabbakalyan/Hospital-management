FROM node:14-alpine3.12
COPY . .
RUN npm install
EXPOSE 3000
CMD ["node","app.js"]
