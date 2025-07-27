FROM ubuntu:latest

RUN apt-get update && apt-get install -y git bash

WORKDIR /app

COPY src/ ./src/

RUN chmod +x src/setup-test.sh src/test.sh src/clean-unwanted-files.sh

CMD ["bash", "-c", "bash src/setup-test.sh && bash src/test.sh"]
