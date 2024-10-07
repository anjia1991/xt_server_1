FROM node:20

WORKDIR /admin

# Set timezone
ENV TZ="UTC"

# Install netcat-openbsd
RUN apt-get update && apt-get install -y netcat-openbsd

# Add label to connect the repository
LABEL org.opencontainers.image.source="https://github.com/${GITHUB_REPOSITORY}"

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies using npm
RUN npm install

# Install Typescript globally
RUN npm i -g typescript

# Copy the rest of the application
COPY . .

# Build the project using npm
RUN npm run build

# Expose port 5000
EXPOSE 5000

# Start the application using npm
CMD ["npm", "run", "start"]