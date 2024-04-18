# Ruby Backend Dockerfile
# Version: 1.0

# Start from the latest Ruby image
FROM ruby:3.3

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set the working directory
WORKDIR /app

# Copy project files into the container
COPY ./back .

# Install gems
RUN bundle install

# Expose the port
EXPOSE 3001

# Start the application
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3001"]