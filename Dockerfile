#--------------------stage 1---------------------

FROM maven:3.8.3-openjdk-17 As builder

WORKDIR /app

COPY . /app

RUN mvn clean install -DskipTests=true

#------------------stage 2---------------------

FROM openjdk:17-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar /app/target/bookstore.jar

EXPOSE 1001

ENTRYPOINT ["java","-jar","/app/target/bookstore.jar"]  
