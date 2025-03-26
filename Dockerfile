# First Stage: Build the JAR
FROM openjdk:17-jdk-slim AS build

WORKDIR /app

# Copy Maven Wrapper and necessary files
COPY mvnw pom.xml ./
COPY .mvn .mvn
COPY src src

# Ensure the Maven wrapper is executable
RUN chmod +x mvnw

# Build the application (JAR)
RUN ./mvnw clean package -DskipTests

# Second Stage: Run the application
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
