Description
===========

Installs the Shibboleth SAML IdP

Requirements
============

Platform
--------

Tested and developed on CentOS

Cookbooks
---------

Requires the stock java and tomcat cookbooks, and works well with our
terracotta cookbook.

Attributes
==========

* `node["shibboleth"]["version"]` - The version of the software we're
installing.  Should match the archive you place in files/default - see
`Usage` below.

* `node['shibboleth']['install_dir']` - Where to unpack the installer. Defaults
to `/opt/src`

* `node['shibboleth']['home']` - Where to install Shibboleth. Defaults to
`/opt/shibboleth-idp`

* `node['shibboleth']['domain']` - Your IdP's domain name. Defaults to
`idp.example.org`

* `node['shibboleth']['keystore_password']` - The password used to encrypt
your java keystore. Defaults to `badpass`.

* `node['shibboleth']['loggers']` - A dictionary of Java classes and
logging levels for each. Defaults are the same as regular Shibboleth.

* `node['shibboleth']['override_providers']` - A list of provider entityIDs
that are valid for this IdP.  Any others set in relying_parties will be
silently ignored.  This exists to conver a strange configuration at UCSF -
most people can safely ignore it.

* `node['shibboleth']['profile_handler_schemas']` - A list of XML schemas to
use in handler.xml.  Defaults are the same as regular Shibboleth.  You'd
want to set this if you're setting a non-default handler.

* `node['shibboleth']['profile_handler_namespaces']` - A list of XML
namespaces to use in handler.xml.  Defaults are the same as regular
Shibboleth.  You'd want to set this if you're setting a non-default handler.

* `node['shibboleth']['extra_servlets']` - A dictionary of extra servlets to
load.  The libraries for these servlets must be listed in extra_libraries. 
For example, to configure the Duo Security two-factor login handler, your
config might look like this:

    "extra_servlets": {
      "TwoFactorLoginHandler": {
        "class": "com.duosecurity.shibboleth.idp.twofactor.TwoFactorLoginServlet",
        "load_on_startup": "4",
        "url_pattern": "/Authn/DuoUserPassword"
      }
    }

* `node['shibboleth']['extra_docs']` - A list of documents (HTML, JSP, CSS,
JS, etc.) to include at the root of the idp.war file.  Each file listed here
must also be added to files/default/

* `node['shibboleth']['extra_libraries']` - A list of extra libraries
to add to the idp.war file. Each file listed here must also be added to
files/default/

* `node['shibboleth']['session_lifetime']` - How long an IdP session lasts,
in milliseconds.  Defaults to 1800000, or 30 minutes.  Remember also to up
the validity of your login handler(s).

* `node['shibboleth']['attributes']` - Data structure defining attributes. 
Defaults to the same set as regular Shibboleth.  See the example below for
the format.

* `node['shibboleth']['trust_certificates']` - A dictionary of names and PEM
certificates that we should import into the Java trusted CA list.  You may
need to use this to be able to connect to an LDAPS server, for example.

* `node['shibboleth']['metadata_directories']` - A list of directories to
look for metadata files in.  All files will be automatically loaded by the
IdP.

* `node['shibboleth']['remote_metadata']` - Data structure defining remote
sources of metadata.  See the example below for the format.  The
"signature_cert" attribute allows you to perform validation of the signature
of the metadata.  It is optional, but if you define it you must also add a
file with that name to the files directory of this cookbook.

* `node['shibboleth']['ldap_resolvers']` - Data structure defining LDAP
resolvers.  See the example below for the format.

* `node['shibboleth']['static_resolvers']` - Data structure defining static
resolvers.  See the example below for the format.

* `node['shibboleth']['computed_resolvers']` - Data structure defining
computed resolvers.  See the example below for the format.

* `node['shibboleth']['default_resolver']` - Which resolver to use for
attributes that don't specify one, including the default set that you don't
have to define.

* `node['shibboleth']['login_modules']` - Data structure defining modules to
use for authentication.  See the example below for the format.

* `node['shibboleth']['relying_parties']` - Data structure defining relying
parties and what attributes we should release to them.  Despite the name,
unless you define a provider, each will only create an entry in
attribute-filter.xml, not relying-parties.xml.  See the example below for
the format.

Usage
=====

Place the Shibboleth IdP binary distribution zip file in the files/default/
directory of this cookbook.  Also place any extra Java libraries you
want to use (e.g. custom login modules) in the same place.

Extract the login.css, login.jsp, and logo.jpg file from the Shibboleth IdP
distribution zip file, customize them, and place them in files/default/ as
well.

Define at least the `version`, `domain`, and `default_resolver` attributes,
and define at least one each of `metadata_directories`/`remote_metadata`,
`ldap_resolvers`, `login_modules`, and `relying_parties`.

Here is an example node configuration:

    {
      "name": "shibboleth-idp",
      ...
      "run_list": [
        ...
        "recipe[tomcat]",
        "recipe[shibboleth-idp]"
      ],
      "override_attributes": {
        ...
        "shibboleth_idp": {
          "session_lifetime": "7200000",
          "trust_certificates": {
            "foo": "-----BEGIN CERTIFICATE-----\n...\n-----END CERTIFICATE-----\n"
          },
          "metadata_directories": [
            "/opt/shibboleth-metadata"
          ],
          "default_resolver": "myLDAP",
          "ldap_resolvers": {
            "myLDAP": {
              "attributes": {
                "ldapURL": "ldaps://ldap.foo.com:636",
                "baseDN": "dc=foo,dc=com",
                "principal": "uid=shibboleth",
                "principalCredential": "not a real password"
              },
              "filter_template": "(uid=$requestContext.principalName)",
              "return_attributes": "uid displayName mail sn givenName"
            }
          },
          "static_resolvers": {
            "staticAttributes": {
              "isAwesome": [ "yes" ]
            }
          },
          "computed_resolvers": {
            "computedID": {
              "source_attribute": "uid",
              "salt": "never put salt in your eyes",
              "dependencies": [ "myLDAP" ]
            }
          },
          "remote_metadata": {
            "incommon": {
              "url": "http://md.incommon.org/InCommon/InCommon-metadata.xml",
              "signature_cert": "inc-md-cert.pem"
            }
          },
          "login_modules": [
            {
              "module": "edu.vt.middleware.ldap.jaas.LdapLoginModule",
              "host": "ldap.foo.com",
              "port": "636",
              "base": "ou=users,dc=foo,dc=com",
              "serviceUser": "uid=shibboleth,dc=ucsf,dc=edu",
              "serviceCredential": "not a real password",
              "userField": "uid"
            }
          ],
          "attributes": {
            "eduPersonPrincipalName": {
              "type": "ad:Scoped",
              "scope": "foo.com",
              "source_attribute": "uid",
              "SAML1ScopedString": "urn:mace:dir:attribute-def:eduPersonPrincipalName",
              "SAML2ScopedString": "urn:oid:1.3.6.1.4.1.5923.1.1.1.6",
              "friendlyName": "ePPN"
            },
            "isAwesome": {
              "resolver": "staticAttributes",
              "SAML1String": "urn:mace:dir:attribute-def:isAwesome",
              "SAML2String": "urn:mace:dir:attribute-def:isAwesome"
            },
            "transientId": {
              "type": "ad:TransientId",
              "resolver": false,
              "SAML1StringNameIdentifier": "urn:mace:shibboleth:1.0:nameIdentifier",
              "SAML2StringNameID": "urn:oasis:names:tc:SAML:2.0:nameid-format:transient"
            }
          },
          "relying_parties": [
            {
              "entityids": [
                "https://sp1a.foo.com/",
                "https://sp1b.foo.com/"
              ],
              "provider": "https://idp2.foo.com/idp/shibboleth",
              "attributes": [ "eduPersonPrincipalName" ]
            },
            {
              "entityids": [ "https://sp2.foo.com/" ],
              "attributes": [ "eduPersonPrincipalName", "surname", "givenName",
                "displayName", "email" ],
              "profile_configuration": {
                "SAML2SSOProfile": {
                  "encryptAssertions": "never"
                }
              }
            }, 
            {
              "groupids": [ "urn:mace:incommon" ],
              "attributes": [ "eduPersonPrincipalName" ]
            }
          ]
        }
      }
    }

License and Author
==================

Author:: Elliot Kendall (<elliot.kendall@ucsf.edu>)

Copyright:: 2012, Regents of the University of California
