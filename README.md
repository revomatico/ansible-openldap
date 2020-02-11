this project is work in progress!!!!!!!!!!!!!


# Ansible playbook to automate OpenLDAP deployment

- Developed and used with Ansible 2.8 on Ubuntu 18.04

## Features
- Deploy N-Way multi master replication
- In containers, using Docker Compose

## Usage
- Copy directory `samples/ansible-inventory` to the project root
- Edit `hosts` and `host_vars` to your needs
- Create a `playbook-vars.yml` file, using the [sample](samples/playbook-vars.yml) as inspiration
- Run `./run-playbook.sh`

## TODO
- [ ] Create molecule tests

## Alternatives
- https://github.com/osixia/docker-openldap
- https://github.com/debops/debops/tree/master/ansible/roles/slapd

## Changelog
- [2020-02-11] v0.0.1
  - Initial release
