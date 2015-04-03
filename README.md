# docker-program-o

Docker image for [Program-O] which is a PHP MySQL AIML Chatbot.

[Program-O]: https://github.com/Program-O/Program-O

## Usage

All data is stored in a mysql database. To have the database on persistent storage, you can either use bind mounts or a data container.
The example in the Makefile uses bind mounts. Just change the db_storage variable to something that suites your needs.

To start Program-O just change the credentials in the Makefile and then run `make run`.

# Alternatives

* [Howie](https://github.com/ypid/docker-howie)

# Credits

This Dockerfile is based on [jchaney/owncloud](https://github.com/jchaney/owncloud).

# Notes
This is not yet tested.
