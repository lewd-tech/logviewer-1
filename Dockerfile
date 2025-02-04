FROM python:3.9-alpine as py

FROM py as build

RUN apk update && apk add build-base
COPY requirements.txt /
RUN pip install --prefix=/inst -U -r /requirements.txt

FROM py

ENV USING_DOCKER yes
COPY --from=build /inst /usr/local

WORKDIR /logviewer
CMD ["python", "app.py"]
COPY . /logviewer