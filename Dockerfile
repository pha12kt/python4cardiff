FROM ipython/ipython:3.x

MAINTAINER IPython Project <ipython-dev@scipy.org>

RUN apt-get install -y -q libpng-dev libfreetype6-dev

COPY requirements.txt /requirements.txt

RUN pip install pip==1.3 && pip install -r /requirements.txt 

COPY notebooks /notebooks
WORKDIR /notebooks

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default
ENV USE_HTTP 1

ADD notebook.sh /
RUN chmod u+x /notebook.sh

CMD ["/notebook.sh"]