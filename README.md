# Ansible Role: Installs Apache Tomcat Java Application server (optionally with Hugepages)

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

    tomcat_use_huge_pages: True

Use Huge Pages (Java calls it: UseLargePages) for enhance performance of Java applications. When a process uses some memory, the CPU is marking the RAM as used by that process. For efficiency, the CPU allocate RAM by chunks of 4K bytes (it's the default value on many platforms). Those chunks are named pages. Those pages can be swapped to disk, etc.

Since the process address space are virtual, the CPU and the operating system have to remember which page belong to which process, and where it is stored. Obviously, the more pages you have, the more time it takes to find where the memory is mapped. When a process uses 1GB of memory, that's 262144 entries to look up (1GB / 4K). If one Page Table Entry consume 8bytes, that's 2MB (262144 * 8) to look-up. 

[Debian Wiki: Hugepages](https://wiki.debian.org/Hugepages)

When you enable it use [KAMI911:hugepages](https://galaxy.ansible.com/KAMI911/hugepages/) to configure Huge Pages in Linux.

    tomcat_file_encoding: UTF-8

Tomcat file encoding parameter: UTF-8

    tomcat_page_encoding: UTF-8

Tomcat page encoding parameter: UTF-8

    tomcat_manage_java_pkg: False

Tomcat manage java installation an install OpenJDK or not.

## Dependencies

None.

## Example Playbook

    - hosts: all
      roles:
        - tomcat

## License

MIT / BSD

## Author Information

This role was created in 2016-2017 by Kálmán Szalai - KAMI
