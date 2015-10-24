# docker-centos7-sshd

## Synopsis

A simple testcontainer providing sshd on CentOS 7

**Do __not__ use this in production, as the private key to access this container is publicly available!**

## Usage

```bash
make run
ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null root@localhost -p 4444 -i alvaroaleman_insecure_private_key
# Test your stuff
# Leave container
make clean
```

## Contributing

If you want to contribute to this repository please be aware that this
project uses a [gitflow](http://nvie.com/posts/a-successful-git-branching-model/)
workflow with the next release branch called ``next``.

Please fork this repository and create a local branch split off of the ``next``
branch and create pull requests back to the origin ``next`` branch.

## License

GNU AFFERO GENERAL PUBLIC LICENSE Version 3

## Author

Alvaro Aleman
