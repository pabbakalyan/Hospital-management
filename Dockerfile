# Use an official Node.js runtime as the base image
FROM node:14

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the application
RUN npm run

# Expose a port if your application needs it (optional)
# EXPOSE 3000

# Define the command to start your application
CMD [ "npm", "start" ]
