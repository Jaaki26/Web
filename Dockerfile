FROM openjdk:17-jdk-slim
WORKDIR /app
COPY target/resume-website-1.0.0.jar resume-website.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "resume-website.jar"]
