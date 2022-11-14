FROM python:3.9-slim AS builder
WORKDIR /app
COPY flask-realworld-example-app/requirements /requirements
RUN pip install --upgrade pip && pip install --no-cache-dir -r /requirements/prod.txt

FROM builder as prod
ENV FLASK_APP=autoapp.py
ENV FLASK_DEBUG=0
COPY flask-realworld-example-app /app
CMD ['flask','run','--with-threads']

FROM builder as dev
RUN pip install --no-cache-dir -r /requirements/dev.txt
ENV FLASK_APP=autoapp.py
ENV FLASK_DEBUG=1
COPY flask-realworld-example-app /app
CMD ['flask','run','--with-threads']