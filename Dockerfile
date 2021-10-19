# syntax=docker/dockerfile:1
FROM --platform=${TARGETPLATFORM:-linux/amd64} python:${TARGETVERSION:-3.9}-buster as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG FLAKE8_IGNORE

# Allows you to add additional packages via build-arg
ARG ADDITIONAL_DEV_PACKAGES

RUN apt-get update \
    &&  apt-get install -y ca-certificates ${ADDITIONAL_DEV_PACKAGES} \
    && rm -rf /var/lib/apt/lists/

# Add non root user
RUN groupadd app && useradd -r -g app app

# set the workdir
WORKDIR /home/app/

# copy from current directory to the image
COPY . .

# install dependencies
RUN pip install -r requirements.txt
# set the correct owner
RUN chown -R app /home/app

# create the user and set the right python path
USER app

# set python as the entrypoint
ENTRYPOINT ["python"]

# execute the script
CMD ["main.py" ]