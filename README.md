# docker-ib-gateway

Docker container that launches the Interactive Brokers Gateway GUI inside of an X virtual frame buffer.

## Usage
First, navgate into the `config/` directory and

    cp tws_credentials.txt_sample tws.credentials.txt

Then, edit tws.credentials and renplace the username and password with your TWS credentials.

Navigate back to the root directory and run the following command to start the server:

    docker-compose build; docker-compose up

At this point, you should be able to connect with VNC and log in to the gateway. Once logged in, port 4001 will be open for you to make API calls against.
