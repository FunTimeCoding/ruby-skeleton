FROM ruby:2.7.4-alpine AS development-docker
RUN mkdir /ruby_skeleton
WORKDIR /ruby_skeleton
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN apk add --virtual build-dependencies build-base
RUN bundle install

FROM ruby:2.7.4-alpine AS development-ssh
RUN apk add --virtual build-dependencies build-base
COPY . /ruby_skeleton
WORKDIR /ruby_skeleton
RUN gem install bundler
# Install bundle packages system wide. Set by environment variable.
RUN bundle config set system true
# Throw error if Gemfile.lock is out of sync
#RUN bundle config --global frozen 1
RUN bundle install
COPY configuration/docker/ruby.sh /etc/profile.d/ruby.sh
RUN chmod +x /etc/profile.d/ruby.sh

# SSH
RUN apk add --update openssh rsync
RUN echo root:root | chpasswd
COPY configuration/docker/sshd.txt /etc/sshd_config
RUN ssh-keygen -A

RUN rm -rf /tmp/* /var/cache/apk/*
COPY configuration/docker/motd.txt /etc/motd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/sshd_config"]
