# Use OpenJDK 17 as the base image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy only necessary files for caching efficiency
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Copy the source code
COPY src src

# Ensure the Maven wrapper is executable
RUN chmod +x mvnw

# Run the Maven build command (this will generate the JAR)
RUN ./mvnw clean package -DskipTests

# Change to the target directory and list files (for debugging)
RUN ls -la /app/target

# Copy the JAR from the correct location
COPY --from=0 /app/target/*.jar app.jar

# Run the application
CMD ["java", "-jar", "app.jar"]
