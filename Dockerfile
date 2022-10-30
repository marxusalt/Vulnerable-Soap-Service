ARG PYTHONPATH=/python/site-packages

FROM python:3.10-alpine3.16 AS builder
ARG PYTHONPATH
COPY Pipfile.lock .
RUN pip install pipenv && pipenv requirements >requirements.txt \
&&  pip install -r requirements.txt --target=$PYTHONPATH

FROM python:3.10-alpine3.16
ARG PYTHONPATH
COPY --from=builder $PYTHONPATH $PYTHONPATH
ENV PYTHONPATH=$PYTHONPATH
WORKDIR /src
COPY . .
