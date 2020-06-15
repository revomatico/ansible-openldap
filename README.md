# Ansible playbook to automate OpenLDAP deployment

- Developed and used with Ansible 2.8 on Ubuntu 18.04

## Features
- Deploy N-Way multi master replication
- In containers, using Docker Compose

## OpenLDAP variants
- Default: [tiredofit/openldap](https://hub.docker.com/r/tiredofit/openldap) image.
- Can use [osixia/openldap](https://hub.docker.com/r/osixia/openldap) as well, but did not appear to work properly with self generated certificates.
    - set: `openldap_image: osixia/openldap`
    - set: `openldap_version` to desired version

## Usage
- Copy directory `samples/ansible-inventory` to the project root
- Edit `hosts` and `host_vars` to your needs
- Create a `playbook-vars.yml` file, using the [sample](samples/playbook-vars.yml) as inspiration
- Deploy: `./run-playbook.sh`
- Remove: `./run-playbook.sh -e docker_compose_command=down`

## TODO
- [ ] Create molecule tests

## Alternatives
- https://github.com/osixia/docker-openldap
- https://github.com/debops/debops/tree/master/ansible/roles/slapd

## Changelog
- [2020-06-12] v0.0.2
  - Replaced `oxisia` release with `tiredofit` release of OpenLDAP
- [2020-02-11] v0.0.1
  - Initial release
