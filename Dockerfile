# Estágio 1: Build da aplicação com o Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Estágio 2: Criação da imagem final com o JRE
FROM eclipse-temurin:21-jre
WORKDIR /app

# Cria um usuário e grupo 'appuser' sem privilégios administrativos
RUN addgroup --system appuser && adduser --system --group appuser

# Copia o artefato da aplicação do estágio de build
COPY --from=build /app/target/brinquedos-0.0.1-SNAPSHOT.jar app.jar

# Define o usuário 'appuser' para executar a aplicação
USER appuser

# Expõe a porta que a aplicação vai usar
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-jar", "app.jar"]