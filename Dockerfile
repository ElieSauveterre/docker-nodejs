#
# Node.js Dockerfile
#
# https://github.com/dockerfile/nodejs
#

# Pull base image.
FROM ruby:1.9.3-slim

RUN apt-get update
RUN apt-get install -y build-essential python wget

# Install Node.js
RUN \
  cd /tmp && \
  wget http://nodejs.org/dist/node-latest.tar.gz && \
  tar xvzf node-latest.tar.gz && \
  rm -f node-latest.tar.gz && \
  cd node-v* && \
  ./configure && \
  CXX="g++ -Wno-unused-local-typedefs" make && \
  CXX="g++ -Wno-unused-local-typedefs" make install && \
  cd /tmp && \
  rm -rf /tmp/node-v* && \
  npm install -g npm && \
  printf '\n# Node.js\nexport PATH="node_modules/.bin:$PATH"' >> /root/.bashrc

# CLEAN UP
RUN apt-get remove -y build-essential python wget


# Grunt needs git
RUN apt-get -y install git

# Install Sass

RUN bash -l -c "gem install sass"

# Install grunt
RUN npm install -g grunt-cli

# Install Bower
RUN npm install -g bower

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["bash"]
