
FROM centos:7

#RUN yum update -y

#RUN yum install -y sudo

RUN useradd -mc /bin/bash postgres

USER postgres
RUN cd ~; python -c "$(curl -fsSL https://bigsql-download.s3.amazonaws.com/REPO/install.py)"

RUN cd ~/bigsql; ./apg install pg11; ./apg start pg11 -y; ./apg status
RUN tail -f /dev/null 

EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/home/postgres/bigsql/data/pg11", "/home/postgres/bigsql/logs/pg11" ]

# Set the default command to run when starting the container
#CMD ["/home/postgres/bigsql/apg", "start", "pg11"]
CMD ["/bin/bash"]
