
# Official Node.Js Base image
FROM node:18-alpine

# Setting up Work Directory
WORKDIR /usr/src/app

# Copying package.json and install dependencies
COPY package*.json ./

# Installing Light weight HTTPS Server(Express)
RUN npm install express

# Copy the rest of the application code
COPY . .

# Expose Internal Port
EXPOSE 3000

# Running the application
CMD ["node", "app.js" ]