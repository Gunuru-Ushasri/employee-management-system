# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy Maven files first (to leverage Docker caching)
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Copy the source code
COPY src src

# Make the Maven wrapper executable
RUN chmod +x mvnw

# Build the application (this ensures JAR creation)
RUN ./mvnw clean package -DskipTests

# Copy the built JAR file
COPY target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
