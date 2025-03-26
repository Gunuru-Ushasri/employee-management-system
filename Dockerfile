# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Maven wrapper and pom.xml first (to leverage Docker caching)
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Copy the source code
COPY src src

# Build the application (this step creates the JAR)
RUN ./mvnw clean package -DskipTests

# Copy the built JAR file
COPY target/EmployeeBackend-0.0.1-SNAPSHOT.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
