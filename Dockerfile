# Use OpenJDK base image
FROM openjdk:17-jdk-slim

# Copy the built jar to the image
COPY target/paytrack-0.0.1-SNAPSHOT.jar app.jar

# Run the jar
ENTRYPOINT ["java","-jar","/app.jar"]
