FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /src
# Set working directory and copy files from local path to container file system path
WORKDIR src/
COPY src/ /src
# Install Ruby ependencies by installing all the required gems
RUN bundle install

LABEL author="Marco Martinez"
LABEL email="markwinap@gmail.com"
LABEL version="1.0"
LABEL description="Home Task"

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 8000

# Start the main process.
CMD ["ruby", "api.rb", "-p", "8000"]