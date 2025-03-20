# Local Environment
Provides local environment with docker compose for local development

## SSL Certificate
If you want to use HTTPS, check [instruction](docker/README.md) 

## Adding files based on *.dist files
* Create .env file in directory docker, based on .env.dist
* If you need to change something in docker-compose.yml you need to create docker-compose.override.yml based on corresponding .dist file
* To provide configuration for web servers you need to create default.template.conf and default.conf in folder docker/etc/app/ based on .dist file

## Run Environment
* Run command docker-compose up --build -d

## Contribute, use
The project is available for personal use and reasonable suggestions for improvement. 