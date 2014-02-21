---
title: 邮件客户端配置
tags:
---

# ThunderBird

## Markdown Here配置

主要关注各结构的margin与padding

## LDAP服务配置

```prefs.js
user_pref("ldap_2.autoComplete.directoryServer", "ldap_2.servers.LDAP");
user_pref("ldap_2.autoComplete.useDirectory", true);
user_pref("ldap_2.servers.LDAP.auth.dn", "xxx@xxx.com");
user_pref("ldap_2.servers.LDAP.auth.saslmech", "");
user_pref("ldap_2.servers.LDAP.autoComplete.commentFormat", "[displayName] [firstName] [surname]([givenName])([department])");
user_pref("ldap_2.servers.LDAP.autoComplete.nameFormat", "[surname] [givenName]");
user_pref("ldap_2.servers.LDAP.description", "LDAP");
user_pref("ldap_2.servers.LDAP.filename", "ldap.mab");
user_pref("ldap_2.servers.LDAP.maxHits", 100);
user_pref("ldap_2.servers.LDAP.uri", "ldaps://ldap.xxx-inc.com/DC=xxx,DC=com??sub?(objectclass=*)");
user_pref("ldap_2.servers.default.autoComplete.nameFormat", "[displayName][givenName][firstName][department]");
user_pref("ldap_2.servers.eds.description", "EDS Address Book Bootstrapper");
user_pref("ldap_2.servers.eds.dirType", 3);
user_pref("ldap_2.servers.eds.filename", "eds.mab");
user_pref("ldap_2.servers.eds.position", 1);
user_pref("ldap_2.servers.eds.uri", "moz-abedsdirectory://");
```
