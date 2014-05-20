#
# Cookbook Name:: shibboleth-idp
# Attributes:: default
#

default["shibboleth_idp"]["version"] = "2.3.8"
default["shibboleth_idp"]["install_dir"] = "/opt/src"
default["shibboleth_idp"]["installer_dir"] = default["shibboleth_idp"]["install_dir"] + "/shibboleth-identityprovider-" + default["shibboleth_idp"]["version"]
default["shibboleth_idp"]["installer_archive"] = default["shibboleth_idp"]["install_dir"] + "/shibboleth-identityprovider-" + default["shibboleth_idp"]["version"] + "-bin.zip"
default["shibboleth_idp"]["home"] = "/opt/shibboleth-idp"
default["shibboleth_idp"]["scope"] = "example.org"
default["shibboleth_idp"]["domain"] = "idp.example.org"
default["shibboleth_idp"]["entity_id"] = "https://" + default["shibboleth_idp"]["domain"] + "/idp/shibboleth"
default["shibboleth_idp"]["idp_metadata"] = nil
default["shibboleth_idp"]["keystore_password"] = "badpass"
default["shibboleth_idp"]["override_providers"] = []
default["shibboleth_idp"]["relying_parties"] = []
default["shibboleth_idp"]["metadata_directories"] = []

default["shibboleth_idp"]["loggers"]["edu.internet2.middleware.shibboleth"] = "INFO"
default["shibboleth_idp"]["loggers"]["org.opensaml"] = "WARN"
default["shibboleth_idp"]["loggers"]["edu.vt.middleware.ldap"] = "WARN"
default["shibboleth_idp"]["audit_log_pattern"] = "%msg%n"

default["shibboleth_idp"]["profile_handler_schemas"] = {
  "urn:mace:shibboleth:2.0:idp:profile-handler" => "shibboleth-2.0-idp-profile-handler.xsd"
}
default["shibboleth_idp"]["profile_handler_namespaces"] = {
  "ph" => "urn:mace:shibboleth:2.0:idp:profile-handler",
  "xsi" => "http://www.w3.org/2001/XMLSchema-instance"
}
default["shibboleth_idp"]["extra_servlets"] = {}
default["shibboleth_idp"]["extra_libraries"] = []
default["shibboleth_idp"]["login_handlers"] = {
  "ph:UsernamePassword" => {
    "authentication_method" => "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
    "attrs" => {}
  }
}
default["shibboleth_idp"]["extra_webapp_libraries"] = []
default["shibboleth_idp"]["extra_docs"] = []
default["shibboleth_idp"]["login_modules"] = {}
default["shibboleth_idp"]["remote_metadata"] = {}
default["shibboleth_idp"]["trust_certificates"] = {}

default["shibboleth_idp"]["default_resolver"] = "myLDAP"
default["shibboleth_idp"]["resolvers"] = {}

default["shibboleth_idp"]["attributes"] = {
  "uid" => {"SAML1String" => "urn:mace:dir:attribute-def:uid", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.1"},
  "email" => {"SAML1String" => "urn:mace:dir:attribute-def:mail", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.3"},
  "homePhone" => {"SAML1String" => "urn:mace:dir:attribute-def:homePhone", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.20"},
  "homePostalAddress" => {"SAML1String" => "urn:mace:dir:attribute-def:homePostalAddress", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.39"},
  "mobileNumber" => {"SAML1String" => "urn:mace:dir:attribute-def:mobile", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.41"},
  "pagerNumber" => {"SAML1String" => "urn:mace:dir:attribute-def:pager", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.42"},
  "commonName" => {"SAML1String" => "urn:mace:dir:attribute-def:cn", "SAML2String" => "urn:oid:2.5.4.3"},
  "surname" => {"SAML1String" => "urn:mace:dir:attribute-def:sn", "SAML2String" => "urn:oid:2.5.4.4"},
  "locality" => {"SAML1String" => "urn:mace:dir:attribute-def:l", "SAML2String" => "urn:oid:2.5.4.7"},
  "stateProvince" => {"SAML1String" => "urn:mace:dir:attribute-def:st", "SAML2String" => "urn:oid:2.5.4.8"},
  "street" => {"SAML1String" => "urn:mace:dir:attribute-def:street", "SAML2String" => "urn:oid:2.5.4.9"},
  "organizationName" => {"SAML1String" => "urn:mace:dir:attribute-def:o", "SAML2String" => "urn:oid:2.5.4.10"},
  "organizationalUnit" => {"SAML1String" => "urn:mace:dir:attribute-def:ou", "SAML2String" => "urn:oid:2.5.4.11"},
  "title" => {"SAML1String" => "urn:mace:dir:attribute-def:title", "SAML2String" => "urn:oid:2.5.4.12"},
  "postalAddress" => {"SAML1String" => "urn:mace:dir:attribute-def:postalAddress", "SAML2String" => "urn:oid:2.5.4.16"},
  "postalCode" => {"SAML1String" => "urn:mace:dir:attribute-def:postalCode", "SAML2String" => "urn:oid:2.5.4.17"},
  "postOfficeBox" => {"SAML1String" => "urn:mace:dir:attribute-def:postOfficeBox", "SAML2String" => "urn:oid:2.5.4.18"},
  "telephoneNumber" => {"SAML1String" => "urn:mace:dir:attribute-def:telephoneNumber", "SAML2String" => "urn:oid:2.5.4.20"},
  "givenName" => {"SAML1String" => "urn:mace:dir:attribute-def:givenName", "SAML2String" => "urn:oid:2.5.4.42"},
  "initials" => {"SAML1String" => "urn:mace:dir:attribute-def:initials", "SAML2String" => "urn:oid:2.5.4.43"},
  "departmentNumber" => {"SAML1String" => "urn:mace:dir:attribute-def:departmentNumber", "SAML2String" => "urn:oid:2.16.840.1.113730.3.1.2"},
  "displayName" => {"SAML1String" => "urn:mace:dir:attribute-def:displayName", "SAML2String" => "urn:oid:2.16.840.1.113730.3.1.241"},
  "employeeNumber" => {"SAML1String" => "urn:mace:dir:attribute-def:employeeNumber", "SAML2String" => "urn:oid:2.16.840.1.113730.3.1.3"},
  "employeeType" => {"SAML1String" => "urn:mace:dir:attribute-def:employeeType", "SAML2String" => "urn:oid:2.16.840.1.113730.3.1.4"},
  "jpegPhoto" => {"SAML1String" => "urn:mace:dir:attribute-def:jpegPhoto", "SAML2String" => "urn:oid:0.9.2342.19200300.100.1.60"},
  "preferredLanguage" => {"SAML1String" => "urn:mace:dir:attribute-def:preferredLanguage", "SAML2String" => "urn:oid:2.16.840.1.113730.3.1.39"},
  "eduPersonPrincipalName" => {"type" => "Prescoped", "SAML1ScopedString" => "urn:mace:dir:attribute-def:eduPersonPrincipalName", "SAML2ScopedString" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.6"},
  "eduPersonAffiliation" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonAffiliation", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.1"},
  "eduPersonEntitlement" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonEntitlement", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.7"},
  "eduPersonNickname" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonNickname", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.2"},
  "eduPersonOrgDN" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonOrgDN", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.3"},
  "eduPersonOrgUnitDN" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonOrgUnitDN", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.4"},
  "eduPersonPrimaryAffiliation" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonPrimaryAffiliation", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.5"},
  "eduPersonPrimaryOrgUnitDN" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonPrimaryOrgUnitDN", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.8"},
  "eduPersonAssurance" => {"SAML1String" => "urn:mace:dir:attribute-def:eduPersonAssurance", "SAML2String" => "urn:oid:1.3.6.1.4.1.5923.1.1.1.11"}
}

# Session timeout in milliseconds. Default 30 minutes
default["shibboleth_idp"]["session_lifetime"] = 1800000

default["shibboleth_idp"]["rsyslog_service"] = "rsyslog"
default["shibboleth_idp"]["rsyslog_conf_dir"] = "/etc/rsyslog.d"
default["shibboleth_idp"]["rsyslog_facility"] = "local1"
default["shibboleth_idp"]["rsyslog_poll_interval"] = "10"
default["shibboleth_idp"]["rsyslog_udp_hosts"] = []
default["shibboleth_idp"]["rsyslog_tcp_hosts"] = []
