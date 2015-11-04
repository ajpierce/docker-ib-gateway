# docker-ib-gateway

Docker container that launches the Interactive Brokers Gateway GUI inside of an X virtual frame buffer.

## Usage

    docker-compose build; docker-compose up

At this point, you should be able to connect with VNC and log in to the gateway. Once logged in, port 4001 will be open for you to make API calls against.
