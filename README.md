# Ansible playbook to automate OpenLDAP deployment

- Developed and used with Ansible 2.8 on Ubuntu 18.04


## Features
- Deploy N-Way multi master replication
- In containers, using Docker Compose
- Generates a custom CA and server certificates for each nodes, signed by this CA.


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
- [ ] Better implementation of seed config (e.g. check before attempting to create base dn in ldap)
- [ ] Automatically load ldif files (with whatever data) in LDAP after deployment


## Current issues
- Password policy (using [ppm.so](https://github.com/ltb-project/ppm)) does not seem to work at the moment, it is simply ignored?!


## Alternatives
- https://github.com/debops/debops/tree/master/ansible/roles/slapd


## Variables
### Playbook specific

| Variable                          | Default                | Description                                                                                           |
|-----------------------------------|------------------------|-------------------------------------------------------------------------------------------------------|
| docker_compose_project            | `openldap`             | Docker compose project name (docker-compose -p)                                                       |
| docker_compose_command            | `up -d`                | Default docker-compose command. Use `-e docker_compose_command=down` for example to remove deployment |
| docker_logging_max_size           | `50m`                  | Maximum docker log file size                                                                          |
| docker_logging_max_file           | `5`                    | Maximum docker log files before recycling                                                             |
| |
| openldap_image                    | `tiredofit/openldap`   | Base docker image. At the moment, [tiredofit](https://hub.docker.com/r/tiredofit/openldap) release seems to be working better than oxisia one      |
| openldap_version                  | `6.9.2`                | Docker image tag                                                                                      |
| |
| ldap_port_plain                   | `389`                  | Plain ldap port                                                                                       |
| ldap_port_ssl                     | `636`                  | TLS ldap port                                                                                         |
| |
| ldap_log_level                    | `256`                  | See *loglevel* in https://www.openldap.org/doc/admin24/slapdconfig.html                               |
| |
| ldap_dir_certs                    | `/etc/ssl/ldap`        | Host directory to persist TLS certificates                                                            |
| ldap_dir_data                     | `/var/lib/ldap`        | Host directory to persist ldap data                                                                   |
| ldap_dir_config                   | `/etc/ldap/slapd.d`    | Host directory to persist ldap configuration                                                          |
| ldap_dir_backup                   | `/var/lib/ldap-backup` | Host directory to persist scheduled dumps                                                             |
| |
| ldap_organisation                 | `myorg`                | Global name of the organization                                                                       |
| ldap_domain                       | `myorg.com`            | LDAP domain (base_dn will be deducted from this)                                                      |
| ldap_pass_admin                   | `changeit`             | *admin* super user password                                                                           |
| ldap_pass_config                  | `changeit`             | *config* super user password                                                                          |
| |
| ldap_wait_retries                 | `20`                   | How many retries before ansible gives up                                                              |
| ldap_wait_delay                   | `10`                   | How many seconds does ansible wait before retrying                                                    |

### tiredofit/openldap specific
> See https://github.com/tiredofit/docker-openldap

| Variable                          | Default     | Description                                                           |
|-----------------------------------|-------------|-----------------------------------------------------------------------|
| ldap_ulimit_n                     | `2048`      | Set Open File Descriptor Limit                                        |
| |
| ldap_backup_config_cron_period    | `0 4 * * *` | Cron expression to schedule OpenLDAP config backup                    |
| ldap_backup_data_cron_period      | `0 4 * * *` | Cron expression to schedule OpenLDAP data backup                      |
| ldap_backup_ttl                   | `15`        | Automatically cleanup backup after how many days                      |
| |
| ldap_ppolicy_check_rdn            | `0`         | Check RDN Parameter (ppm.so - see https://github.com/ltb-project/ppm) |
| ldap_ppolicy_forbidden_characters | `''`        | Forbidden Characters (ppm.so)                                         |
| ldap_ppolicy_max_consec           | `2`         | Maximum Consective Character Pattern                                  |
| ldap_ppolicy_min_digit            | `1`         | Minimum Digit Characters                                              |
| ldap_ppolicy_min_lower            | `4`         | Minimum Lowercase Characters                                          |
| ldap_ppolicy_min_points           | `3`         | Minimum Points required to pass checker                               |
| ldap_ppolicy_min_punct            | `1`         | Minimum Punctuation Characters                                        |
| ldap_ppolicy_min_upper            | `1`         | Minimum Uppercase Characters                                          |
| ldap_ppolicy_use_cracklib         | `1`         | Use Cracklib for verifying words (ppm.so)                             |
| |
| ldap_tls_cipher_suite             |             | TLS cipher suite. Default: `ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:-DHE-DSS:-RSA:!aNULL:!MD5:!DSS:!SHA` |
| ldap_tls_dh_param_keysize         | `2048`      | TLS DHParam Keysize                                                   |
| |
| ldap_debug_mode                   | `'false'`   | Enable debug (dumps to ouput script output, etc)                      |
| |
| ldap_enable_zabbix                | `'false'`   | Enable zabbix monitoring agent                                        |


## Changelog
- [2020-06-19] v0.0.4
  - Bump tiredofit/openldap version to 6.9.2
  - Update README
- [2020-06-12] v0.0.2
  - Replaced `oxisia` release with `tiredofit` release of OpenLDAP
- [2020-02-11] v0.0.1
  - Initial release
