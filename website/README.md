# RageDB Chemicals and Products Demo

## running

    mvn clean jooby:run

## building

    mvn clean package

## docker

     docker build . -t website
     docker run -p 8080:8080 -it website
