# Use official Java runtime as base image
FROM openjdk:17-jdk-slim

# Set working directory in the container
WORKDIR /app

# Copy built JAR file into the container
COPY target/*.jar app.jar

# Expose the correct port (9090)
EXPOSE 9090

# Command to run the application
CMD ["java", "-jar", "app.jar"]
COPY target/EmployeeBackend-0.0.1-SNAPSHOT.jar app.jar






