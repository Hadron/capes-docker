FROM python:3

WORKDIR /usr/src/app

RUN mkdir -p /usr/share/ca-certificates/range
COPY range.crt /usr/share/ca-certificates/range/range.crt
RUN egrep -v -e '^[!]?range/range.crt' /etc/ca-certificates.conf > /tmp/ca-certificates.conf
RUN echo range/range.crt >> /tmp/ca-certificates.conf
RUN mv /tmp/ca-certificates.conf /etc/ca-certificates.conf
RUN update-ca-certificates

COPY cacert.pem /usr/lib/python2.7/site-packages/pip/_vendor/requests/cacert.pem
COPY cacert.pem /usr/local/lib/python3.9/site-packages/pip/_vendor/certifi/cacert.pem

RUN pip install --no-cache-dir requests

COPY . .
