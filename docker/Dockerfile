FROM ubuntu:latest

RUN apt-get update && apt-get install -y git bash

WORKDIR /app

COPY test ./test
ADD .github/actions/clean-unwanted-files.sh ./test

RUN chmod -R +x ./test/shell

CMD ["bash", "-c", "bash test/shell/setup.sh && bash test/shell/test.sh"]
