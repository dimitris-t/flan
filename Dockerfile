FROM python:3.5-alpine

RUN apk add nmap
RUN apk add nmap-scripts
RUN apk add git

RUN pip install xmltodict
RUN pip install google-cloud-storage
RUN pip install boto3

RUN git clone https://github.com/vulnersCom/nmap-vulners /usr/share/nmap/scripts/vulners
RUN nmap --script-updatedb
RUN mkdir /shared

COPY run.sh /
COPY output_report.py /
COPY latex_header.tex /
COPY gcp_push.py /
COPY aws_push.py /
COPY shared /shared

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
