# Ansible Role: Installs Apache Tomcat Java Application server (optionally with Hugepages)

Installs Apache Tomcat Java Application server. Most complete Tomcat installation, supporting, init.d script, application naming, hugepages, hardening, beautiful error pages, sha512 hashed passwords, JMX configuration, multiple Tomcat versions, separated catalina_home and caralina_base.

[![Build Status](https://github.com/KAMI911/ansible-role-tomcat/actions/workflows/test_ansible_module.yml/badge.svg)](https://github.com/KAMI911/ansible-role-tomcat/actions/workflows/role_test.yml)

## Table of Contents

1. [Requirements][Requirements]
2. [Installation][Installation]
3. [Role Variables][Role Variables]
4. [Dependencies][Dependencies]
5. [Example Playbook][Example Playbook]
6. [Licensing][Licensing]
7. [Author Information][Author Information]
8. [Support][Support]
9. [Contributing][Contributing]
10. [Donation][Donation]

## Requirements

None.

## Installation

    ansible-galaxy install kami911.tomcat

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

### Installation releted options

    tomcat_manage_java_pkg: False

Tomcat manage java installation an install OpenJDK or not.

    tomcat_installer_force_download: true

Always download the installation file. If already downloaded try to redownload it.

    tomcat_download_mirror: https://archive.apache.org

The mirror to download the installation file.

    tomcat_download_url: '{{ tomcat_download_mirror }}/dist/tomcat/tomcat-{{ tomcat_majorversion }}/v{{ tomcat_majorversion }}.{{ tomcat_minorversion }}.{{ tomcat_patchversion }}/bin/{{ tomcat_download_file }}'

The full URL to the installation file.

    tomcat_installer_force_overwrite: true

Always overwrite the installation file on the target machine.

    tomcat_installer_keep: true

Do not delete the installer after the successful installation.

    tomcat_installer_local: false

Download installation installation file to the Ansible host machine (not to the target machine) diredctly. Ansible will download and copy he installation file from the Ansible host machine.

    tomcat_download_validate_certs: false

Validate cert doring the external installation file download.

    tomcat_force_update: false

Force update when same version is already installed. Old version is always updated.

### Version related options

    tomcat_majorversion: 8

Tomcat major version.

    tomcat_minorversion: 5

Tomcat minor version.

    tomcat_patchversion: 4

Tomcat micro version.

    tomcat_java_version: 11

Configure Tomcat to use the specified version version of Java.

### Hugepages usage related options

    tomcat_use_huge_pages: True

Use Huge Pages (Java calls it: UseLargePages) for enhance performance of Java applications. When a process uses some memory, the CPU is marking the RAM as used by that process. For efficiency, the CPU allocate RAM by chunks of 4K bytes (it's the default value on many platforms). Those chunks are named pages. Those pages can be swapped to disk, etc.

Since the process address space are virtual, the CPU and the operating system have to remember which page belong to which process, and where it is stored. Obviously, the more pages you have, the more time it takes to find where the memory is mapped. When a process uses 1GB of memory, that's 262144 entries to look up (1GB / 4K). If one Page Table Entry consume 8bytes, that's 2MB (262144 * 8) to look-up.

[Debian Wiki: Hugepages](https://wiki.debian.org/Hugepages)

When you enable it use [KAMI911:hugepages](https://galaxy.ansible.com/KAMI911/hugepages/) to configure Huge Pages in Linux.

### Port, connection, and firewall related options

    tomcat_manage_firewalld: true

Role manages the firewalld settings of required ports.

    tomcat_enable_firewalld: false

Force install and enable firewalld service.

    tomcat_manage_firewalld_use_zone: true

Tomcat firewalld uses zones (default) or use source addresses.

A "Connector" represents an endpoint by which requests are received and responses are returned. Documentation at :
 * Java HTTP Connector: /docs/config/http.html
 * Java AJP  Connector: /docs/config/ajp.html
 * APR (HTTP/AJP) Connector: /docs/apr.html

Define a non-SSL/TLS HTTP/1.1 Connector

All the configuration related to connectors, port, and firewall are collected under variable named tomcat_server:

    tomcat_server:
      - port: 8080  # Tomcat listening http connection port.
        connector:
          protocol: 'HTTP/1.1'
          connectionTimeout: 20000
          redirectPort: 8444
          Server: ' '
          URIEncoding: UTF-8
          Secure: false
          compressibleMimeType: 'text/html,text/xml,text/css,text/javascript,application/x-javascript,application/javascript,text/plain'  # Tomcat http connection compressed MIME-types.
          compression: on  # Tomcat http connection compressed content enable/disable.
          compressionMinSize: 256  # Tomcat http connection min compressed file size.
          noCompressionUserAgents: ''  # Tomcat http connection must be uncompressed for these browser user agents.
        source: []  # Tweak this according yout network
        #  - '192.168.10.0/24'
        #  - '172.20.10.0/23'
        executor:  # Specify executor if you want to use this. Do not forget to use it in connector settings via 'executor' key.
          name: tomcatHTTPThreadPool
          namePrefix: catalina-exec-http-
          maxThreads: 300
          minSpareThreads: 5
      - port: 8009  # Tomcat listening http connection port.
        connector:
          protocol: 'AJP/1.3'
          redirectPort: 8444
        source: []  # Tweak this according yout network
        #  - '0.0.0.0/0'
        #  - '60.60.60.60/0'
        executor:    # Specify executor if you want to use this. Do not forget to use it in connector settings via 'executor' key.
          name: tomcatAJPThreadPool
          namePrefix: catalina-exec-ajp-
          maxThreads: 900
          minSpareThreads: 20
        # zone: []  # Tomcat listening http connection port firewall zone.
        #  - 'internal'

Tomcat "Connector" can use the shared thread pool called executor for http/ajp/https connections.

### Encoding related options

    tomcat_file_encoding: UTF-8

Tomcat file encoding parameter: UTF-8

    tomcat_page_encoding: UTF-8

Tomcat page encoding parameter: UTF-8

### Locale related options

Locales identify a specific language and geographic region.

More information about Java's locale settings are available here:
https://www.oracle.com/technical-resources/articles/javase/locale.html

    tomcat_locale_language: en

Language codes are defined by ISO 639, an international standard that assigns two- and three-letter codes to most languages of the world. Locale uses the two-letter codes to identify the target language.

    tomcat_locale_country: EN

Country codes are defined by ISO 3166, another international standard. It defines two- and three-letter abbreviations for each country or major region in the world. In contrast to the language codes, country codes are set uppercase.

    tomcat_locale_region:

Country codes and regions are defined by ISO 3166, another international standard.

    tomcat_locale_variant:

Operating system (OS), browser, and other software vendors can use the code to provide additional functionality or customization that isn't possible with just a language and country designation. For example, a software company may need to indicate a locale for a specific operating system, so its developers may create an es_ES_MAC or an es_ES_WIN locale for the Macintosh or Windows platforms for customers in Spain.

### Memory configuration related options

    tomcat_java_heap_min: 4096

Java minimum Heap size. Memory sizes in megabytes (m).

    tomcat_java_heap_max: 4096

Java maximum Heap size. Memory sizes in megabytes (m).

    tomcat_java_permsize_min: 384

Java minumum permanent generation size. Memory sizes in megabytes (m). Only for Java 7 or older.

    tomcat_java_permsize_max: 384

Java minumum permanent generation size. Memory sizes in megabytes (m). Only for Java 7 or older.

    tomcat_java_thread_stack_size: 512

Java thread stack size in kilobytes (k)

#### Additional Java parameters

[Check Java parameters by versions.](https://chriswhocodes.com/vm-options-explorer.html)

### Native library related options

    tomcat_native_library_enable: false

Try to use Tomcat Native Library.  The Apache Tomcat Native Library is an optional component for use with Apache Tomcat that allows Tomcat to use certain native resources for performance, compatibility, etc.

More information: https://tomcat.apache.org/native-doc/

### Logging related options

    tomcat_catalina_logs_directory_mode: "u=rwx,g=rwx,o="

Tomcat catalina logs directory mode.

    tomcat_access_log_filename: '{{ tomcat_system_name }}_access'

Set Tomcat's access log default filename.

    tomcat_access_log_extension: '.log'

Set Tomcat's access log default file extension.

    tomcat_access_log_pattern: "%{yyyy-MM-dd}tT%{HH:mm:ss.SSSXXXZ}t ${shortSystemName} %v %h (%{X-Forwarded-For}i) %A:%p %I %u &quot;%r&quot; %s %b %D %{Referer}i %{User-Agent}i"


Pattern string of Tomcat access log. Tomcat [Access Logging](https://tomcat.apache.org/tomcat-9.0-doc/config/valve.html#Access_Logging):

Values for the pattern attribute are made up of literal text strings, combined with pattern identifiers prefixed by the "%" character to cause replacement by the corresponding variable value from the current request and response. The following pattern codes are supported:

    %a - Remote IP address
    %A - Local IP address
    %b - Bytes sent, excluding HTTP headers, or '-' if zero
    %B - Bytes sent, excluding HTTP headers
    %h - Remote host name (or IP address if enableLookups for the connector is false)
    %H - Request protocol
    %l - Remote logical username from identd (always returns '-')
    %m - Request method (GET, POST, etc.)
    %p - Local port on which this request was received. See also %{xxx}p below.
    %q - Query string (prepended with a '?' if it exists)
    %r - First line of the request (method and request URI)
    %s - HTTP status code of the response
    %S - User session ID
    %t - Date and time, in Common Log Format
    %u - Remote user that was authenticated (if any), else '-'
    %U - Requested URL path
    %v - Local server name
    %D - Time taken to process the request in millis. Note: In httpd %D is microseconds. Behaviour will be aligned to httpd in Tomcat 10 onwards.
    %T - Time taken to process the request, in seconds. Note: This value has millisecond resolution whereas in httpd it has second resolution. Behaviour will be align to httpd in Tomcat 10 onwards.
    %F - Time taken to commit the response, in millis
    %I - Current request thread name (can compare later with stacktraces)
    %X - Connection status when response is completed:
        X = Connection aborted before the response completed.
        + = Connection may be kept alive after the response is sent.
        - = Connection will be closed after the response is sent.

 There is also support to write information incoming or outgoing headers, cookies, session or request attributes and special timestamp formats. It is modeled after the Apache HTTP Server log configuration syntax. Each of them can be used multiple times with different xxx keys:

    %{xxx}i write value of incoming header with name xxx
    %{xxx}o write value of outgoing header with name xxx
    %{xxx}c write value of cookie with name xxx
    %{xxx}r write value of ServletRequest attribute with name xxx
    %{xxx}s write value of HttpSession attribute with name xxx
    %{xxx}p write local (server) port (xxx==local) or remote (client) port (xxx=remote)
    %{xxx}t write timestamp at the end of the request formatted using the enhanced SimpleDateFormat pattern xxx

All formats supported by SimpleDateFormat are allowed in %{xxx}t. In addition the following extensions have been added:

    sec - number of seconds since the epoch
    msec - number of milliseconds since the epoch
    msec_frac - millisecond fraction

These formats cannot be mixed with SimpleDateFormat formats in the same format token.

Furthermore one can define whether to log the timestamp for the request start time or the response finish time:

    begin or prefix begin: chooses the request start time
    end or prefix end: chooses the response finish time

By adding multiple %{xxx}t tokens to the pattern, one can also log both timestamps.

The shorthand pattern pattern="common" corresponds to the Common Log Format defined by '%h %l %u %t "%r" %s %b'.

The shorthand pattern pattern="combined" appends the values of the Referer and User-Agent headers, each in double quotes, to the common pattern.

    tomcat_juli_logging_format: "%1$tY.%1$tm.%1$tdT%1$tT.%1$tL%1$tz ${shortSystemName} %4$-4s %5$s [%2$s]%6$s%n"


Logging format for general Tomcat logs.

The timestamp format is described here:
https://docs.oracle.com/javase/7/docs/api/java/util/Formatter.html#dt
https://docs.oracle.com/javase/7/docs/api/java/text/SimpleDateFormat.html

Format is described here:
https://docs.oracle.com/javase/7/docs/api/java/util/logging/SimpleFormatter.html#format(java.util.logging.LogRecord)


    tomcat_juli_logging_handler: "AsyncFileHandler" # TODO: Tomcat 6-7 uses only FileHandler

Use AsyncFileHandler for never Tomcat 8-9.

    tomcat_juli_logging_level: "FINE"

Set [1catalina|2localhost|3manager|4host-manager].org.apache.juli.AsyncFileHandler.level and java.util.logging.ConsoleHandler.level to this loglevel. Possible values are:
  SEVERE, WARNING, INFO, CONFIG, FINE, FINER, FINEST or ALL. Default is FINE.

    tomcat_java_gc_log: "-Xlog:gc*=debug,heap*=debug,safepoint=debug,age*=debug,stringdedup*=debug,gc+heap=trace:'${CATALINA_BASE}/logs/gc/gc_%t_%p.log':time,uptimenanos,pid,tid,level,tags:filecount=200,filesize=1G"

Set format and location of GC log.

    tomcat_java_gc_log_old: "-Xloggc:'${CATALINA_BASE}/logs/gc/gc_$(date +%Y-%m-%d_%H%M).log' -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCDateStamps -XX:+PrintGCApplicationStoppedTime -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=200 -XX:GCLogFileSize=1G -XX:+PrintHeapAtGC -XX:+PrintTenuringDistribution -XX:+PrintStringDeduplicationStatistics"

Set format and location of GC log for Java versions older than 9.

### Tomcat hardening related options

    tomcat_use_secure_flag: True

Set this attribute to True if you wish to have calls to request.isSecure() to return true for requests received by this Connector. You would want this on an SSL Connector or a non SSL connector that is receiving data from a SSL accelerator, like a crypto card, a SSL appliance or even a webserver. The default value is False.

    tomcat_session_http_only: True

Forcing Tomcat to use JSESSIONID cookie over only http.

    tomcat_session_secure: True

Forcing Tomcat to use secure JSESSIONID cookie.

### Naming, folders, service related options

    tomcat_system_name: "tomcat_app_sys"

Optional: Use this folder name for this tomcat instance.

    tomcat_short_system_name: 'TT'

Optional: Use this identifier for tagging related files like logs.

    tomcat_service_enabled: true

Enable or disable tomcat service on system startup.

    tomcat_system_home: "{{ tomcat_base_folder }}/{{ tomcat_system_user }}"

Folder of Tomcat binaries.

    # tomcat_system_home: "{{ tomcat_base_folder }}/{{ tomcat_system_name }}" # This is an optional setting to use tomcat_system_name for this system.

Folder of Tomcat binaries using tomcat_system_home variable.

    tomcat_catalina_home: "{{ tomcat_system_home }}/tomcat"

Tomcat Cataline home folder.

    tomcat_catalina_base: "{{ tomcat_catalina_home }}"

Tomcat Catalina base folder.

### Tomcat JMX access configuration

    tomcat_jmx_authenticate: true

Enable or disable JMX authentication.

    tomcat_jmx_users:
    - user: monitoring
        pass: IAGeqqIFpLEiSxWpIhnASaDI31ds
        type: readonly
    - user: administrator
        pass: fYHKXKa68MKQcaq9S8BUEFP8dSN7
        type: readwrite

Define JMX users with name role and password.

### Tomcat LDAP authentication configuration related options

    tomcat_ldap_enable: false

Enable Tomcat LDAP authentication. Disabled by default.

    tomcat_ldap_debug_level: 99

Tomcat LDAP authentication debug level. Default is 99.

    tomcat_ldap_url: 'ldap://ldap.cloud.department.ca:389'

Tomcat LDAP authentication URL. Do not use the default value. Tweak this value according your settings.

    tomcat_ldap_user: 'technicaluser@cloud.department.ca'

Tomcat LDAP user to reach LDAP server. Do not use the default value. Tweak this value according your settings.

    tomcat_ldap_pass: 'password'

Tomcat LDAP user's password to reach LDAP server. Do not use the default value. Tweak this value according your settings.

    tomcat_ldap_user_ou: 'ou=Users,dc=cloud,dc=department,dc=ca'

Organization Unit of valid users for Tomcat LDAP authentication. Tweak this value according your settings.

    tomcat_ldap_user_name: "(sAMAccountName={0})"

Name of authenticated users for Tomcat LDAP authentication. Default setting is (sAMAccountName={0}) which perfect for Windows Active Directory.

    tomcat_ldap_user_referrals: 'follow'

Referrals allow a directory tree to be partitioned and distributed between multiple LDAP servers, which means that LDAP servers may not store the entire
DIT while still being capable of containing references to other LDAP servers that offer requested information instead. So, when you browse a directory,
an LDAP server can refer you to another server by returning referrals. A referral is an entry with the referral objectClass, which contains at least one
attribute named ref having an LDAP URL of the referred entry on another LDAP server as its value.
https://www.ldapadministrator.com/resources/english/help/la20121/ch05s05.html

    tomcat_ldap_user_subtree: true

Tomcat LDAP user could be on the subtree of Organization Unit.

    tomcat_ldap_role_ou: 'ou=TomcatAdmin,ou=Groups,dc=cloud,dc=department,dc=ca'

Organization Unit of group of users for Tomcat LDAP authentication. Tweak this value according your settings. Create security groups here with the Tomcat role names like "manager-gui".

    tomcat_ldap_role_name: 'name'

User security group name as Tomcat role names like "manager-gui". Default is good if you want to use Tomcat role names.

    tomcat_ldap_role_subtree: true

Tomcat LDAP group could be on the subtree of Organization Unit.

    tomcat_ldap_role_search: '(member={0})'

Every member matching the security group's name could access the server as specified in the role.

### Debug port related options

    tomcat_debug_enable: false

Enable Tomcat debug port.

    tomcat_debug_port: 8000

Specify Tomcat debug port.

    tomcat_debug_sever: '{{ ansible_hostname }}' # or 127.0.0.1

Permit connection from all location of from local connection only.

    tomcat_debug_parameter: '-agentlib:jdwp=transport=dt_socket,address={{ tomcat_debug_sever }}:{{ tomcat_debug_port }},server=y,suspend=n'

Specify Tomcat debug parameters.

### Third party profiler related options

    tomcat_profiler_enable: false

Enable Tomcat profiling.

    tomcat_profiler_parameter: '-agentpath:/opt/profiler/libyjpagent.so=port=8200-8220,listen=all,delay=10000'

Specify external parameter of profiler for Tomcat.

### Tomcat log compression options

    tomcat_log_rotate_minsize: 20K

Log files are rotated when they grow bigger than size bytes, but not before the additionally
specified time interval (daily, weekly, monthly, or yearly). The related size option is
 similar except that it is mutually exclusive with the time interval options, and it causes
log files to be rotated without regard for the last rotation time. When minsize is used,
both the size and timestamp of a log file are considered.

    tomcat_log_compress_command: '/usr/bin/xz'

Location is the compressor program. Default is xz so the dafault value is '/usr/bin/xz'.
You can also use for example: '/usr/bin/gzip'.

    tomcat_log_compress_options: '-3'

Options for compression program. For xz the default is '-3' that means well-balanced compression.
For gzip íou can use for example: '-9'.

    tomcat_log_compress_extension: '.xz'

File extension for logrotate specification. xz is '.xz', and gzip is 'gz'.

### Tomcat security settings

    tomcat_security_random_device: random

There are two general random devices on Linux: /dev/random and /dev/urandom. The best randomness comes from /dev/random, since it's a blocking device, and will wait until sufficient entropy is available to continue providing output. Assuming your entropy is sufficient, you should see the same quality of randomness from /dev/urandom; however, since it's a non-blocking device, it will continue producing “random” data, even when the entropy pool runs out. This can result in lower quality random data, as repeats of previous data are much more likely. Lots of bad things can happen when the available entropy runs low on a production server, especially when this server performs cryptographic functions.
If your hardware supoports hardware based random device, then you might use rngd and check randomness with rngtest tool from rng-tools package.
If your hardware does not supoport hardware based random device, then you might use haveged from haveged package. Both package can lower the Tomcat startup time and crypto related actions' time.
The dafault setting provides the "-Djava.security.egd=file:///dev/./random" which is the best for crypto settings when you enable rngd or haveged.

## Dependencies

None.

## Example Playbook

    - hosts: all
      roles:
        - tomcat

## Licensing

The Tomcat Ansible Role application and documantations are licensed under the terms of
the MIT / BSD, you will find a copy of this license in the
[LICENSE](LICENSE) file included in the source package.

## Author Information

This role was created in 2016-2020 by Kálmán Szalai - KAMI

## Support

If you have any question, do not hesitate and drop me a line.
If you found a bug, or have a feature request, you can [fill an issue](https://github.com/KAMI911/ansible-role-tomcat/issues).

### Using as a submudule of an AWX playbook

#### Add as a submodule

```
git submodule add --force git@github.com:KAMI911/ansible-role-tomcat.git roles/tomcat
```

#### Update as sumodule

Update only this submodule

```
git submodule update --remote roles/tomcat/
```

Update all submodules:

```
git submodule foreach git pull origin master
```

## Contributing

There are many ways to contribute to ansible-role-tomcat -- whether it be sending patches,
testing, reporting bugs, or reviewing and updating the documentation. Every
contribution is appreciated!

Please continue reading in the [contributing chapter](CONTRIBUTING.md).

### Fork me on Github

https://github.com/KAMI911/ansible-role-tomcat

Add a new remote `upstream` with this repository as value.

```
git remote add upstream https://github.com/KAMI911/ansible-role-tomcat.git
```

You can pull updates to your fork's master branch:

```
git fetch --all
git pull upstream HEAD
```

## Donation

If you find this useful, please consider a donation:

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RLQZ58B26XSLA)

<!-- TOC URLs -->
[Requirements]: #requirements
[Installation]: #installation
[Role Variables]: #role_variables
[Dependencies]: #dependencies
[Example Playbook]: #example_playbook
[Licensing]: #licensing
[Author Information]: #author_information
[Support]: #support
[Contributing]: #contributing
[Donation]: #donation
