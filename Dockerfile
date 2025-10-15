#
#
#FROM maven:3.8.3-openjdk-17 AS build
#COPY . .
#RUN mvn clean install
#
##
## Package stage
##
#FROM openjdk
#COPY --from=build /target/Assistant.jar
## ENV PORT=8080
#EXPOSE 8080
#ENTRYPOINT ["java","-jar","Assistant.jar"]


# Build stage
FROM maven:3.8.3-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

RUN ls -l /app/target/

# Package stage
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY --from=build /app/target/Assistant-0.0.1-SNAPSHOT.jar.original /app/Assistant.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","Assistant.jar"]
