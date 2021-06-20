FROM ruby:3.0.1-alpine3.13

RUN apk add --update --no-cache \
  bash \
  # Metapackage that pulls packages used to build other packages.
  build-base \
  curl \
  # Determines the type of a file.
  file \
  git \
  # GNU Standard C++ library.
  libstdc++ \
  # The headers and static library files used for building programs that use
  # libffi, a foreign function interface library for bridging interpreted
  # and compiled code.
  libffi-dev \
  linux-headers \
  # For developing programs which use the GNOME XML library.
  libxml2-dev \
  # Development files for libxslt, a C implementation of XSLT, which defines
  # transformations of XML to other formats.
  libxslt-dev \
  # Cryptographic functions.
  libgcrypt-dev \
  make \
  # TCP/IP Swiss Army knife.
  netcat-openbsd \
  nodejs \
  # SSL toolkit/cryptographic utility.
  openssl \
  # System for managing library compile and link flags.
  pkgconf \
  postgresql-dev \
  # Timezone data.
  tzdata \
  vim \
  yarn

# Guarantee parity between the containerized environment and Gemfile.lock.
ARG BUNDLER_VERSION=2.2.15
ENV BUNDLER_VERSION=${BUNDLER_VERSION}
RUN gem install bundler -v ${BUNDLER_VERSION}

WORKDIR /app

COPY Gemfile Gemfile.lock ./
# Builds nokogiri with the libxml2 and libxslt library versions added to the
# container above.
RUN bundle config build.nokogiri --use-system-libraries
# Check gems aren't already installed before installing.
RUN bundle check || bundle install

COPY package.json yarn.lock ./
RUN yarn install --check-files

# Copy remaining application code.
COPY . ./

EXPOSE 3000

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
