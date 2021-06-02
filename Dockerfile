FROM python:3.7

# Because we need this for python-mysqldb and python-ldab for clouddb
RUN apt-get update && apt-get -y install \
    python3.7-dev \
    libmariadb-dev \
    libldap2-dev \
    libsasl2-dev \
    libffi-dev \
    libssl-dev
RUN apt-get update && \
    apt-get install -y curl gnupg && \
    echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - && \
    apt-get update -y && \
    apt-get install google-cloud-sdk -y
ADD requirements.txt /requirements.txt
RUN pip install -r /requirements.txt
RUN mkdir -p /py

# may be added via "tars" in container_image
# use the /py/ directory and untar
ENV PYTHONPATH="/py/"
ENTRYPOINT ["python"]
