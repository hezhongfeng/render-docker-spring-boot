#
# Build stage
#
# Use the official maven/Java 8 image to create a build artifact.
# https://hub.docker.com/_/maven
FROM gradle:jdk17-jammy as builder
#
# # Copy local code to the container image.
COPY . .
#
# # Build a release artifact.
RUN gradle clean build

#
# Package stage
#
#以openjdk:17为基础镜像
FROM eclipse-temurin:17-jdk-jammy as runtime
#暴露8080端口 我的项目用的默认8080端口，你们的项目根据项目的情况选择
EXPOSE 8080
#将项目打包后的jar包添加到镜像中并重命名为app.jar(docker-springboot-demo-1.0-SNAPSHOT.jar就是你们的jar包名称)
ADD build/libs/docker-0.0.1-SNAPSHOT.jar app.jar
#镜像启动时执行的命令，其实就是 docker run时执行'java -jar /app.jar'
ENTRYPOINT ["java","-jar","/app.jar"]