# Ansible Role: Installs Apache Tomcat Java Application server

Installs Apache Tomcat Java Application server

Travis status:   [![Build Status](https://travis-ci.org/KAMI911/ansible-role-tomcat.svg?branch=master)](https://travis-ci.org/KAMI911/ansible-role-tomcat)
Code Climate status: [![Code Climate](https://codeclimate.com/github/KAMI911/ansible-role-tomcat/badges/gpa.svg)](https://codeclimate.com/github/KAMI911/ansible-role-tomcat)
Test Coverage status: [![Test Coverage](https://codeclimate.com/github/KAMI911/ansible-role-tomcat/badges/coverage.svg)](https://codeclimate.com/github/KAMI911/ansible-role-tomcat/coverage)

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    tomcat_majorversion: 8

Tomcat major version.

    tomcat_minorversion: 5

Tomcat minor version.

    tomcat_patchversion: 4

Tomcat micro version.

## Dependencies

None.

## Example Playbook

    - hosts: all
      roles:
        - hugepages

## License

MIT / BSD

## Author Information

This role was created in 2016 by Kálmán Szalai
