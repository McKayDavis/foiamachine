# FOIAMachine Dockerfile
# by https://github.com/McKayDavis
# FOIAMachine from: https://github.com/cirlabs/foiamachine

# use same common base as mysql to share resources
FROM debian:wheezy

RUN apt-get update -y

RUN apt-get install -y \
    libmemcached-dev \
    mercurial \
    meld \
    python-dev \
    libmysqlclient-dev \
    git \
    python-pip \
    mysql-client


COPY requirements.txt /app/

RUN cd /app/ && \
    pip install -r requirements.txt

COPY . /app/

ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]


