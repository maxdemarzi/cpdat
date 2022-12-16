# RageDB Chemicals and Products Demo


Data Sources:

- [CPDat](https://gaftp.epa.gov/COMPTOX/Sustainable_Chemistry_Data/Chemistry_Dashboard/CPDat/CPDat2020-12-16/)

## running

    mvn clean jooby:run

## building

    mvn clean package

## docker

     docker build . -t website
     docker run -p 8080:8080 -it website
