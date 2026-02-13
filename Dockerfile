FROM hashicorp/terraform:1.8.5

RUN apk add --no-cache bash git make py3-pip python3

WORKDIR /workspace

COPY requirements-dev.txt pyproject.toml ./
RUN pip3 install --no-cache-dir -r requirements-dev.txt

COPY . .

ENV PYTHONPATH=/workspace/tools

CMD ["make", "smoke"]
