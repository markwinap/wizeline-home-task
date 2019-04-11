FROM ruby:2.5
# Set working directory and copy files from local path to container file system path
WORKDIR /src
COPY src/ /src
# Install Ruby ependencies by installing all the required gems (Sinatra)
RUN bundle install
#Labels
LABEL author="Marco Martinez"
LABEL email="markwinap@gmail.com"
LABEL version="1.0"
LABEL description="Home Task"
# Listens to TCP port 8000
EXPOSE 8000
# Start the main process.
CMD ["ruby", "api.rb", "-p", "8000"]