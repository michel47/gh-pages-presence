---
layout: post
title:  "Moving DNSRecord arround"
date:   2019-08-25 16:26:21 +0200
categories: admin
keywords: DNS, registrar
PGW: https://gateway.ipfs.io
search_url: https://duckduckgo.com/?q
---

I am managing a set of website and I never remember
which registrar and or DNS is managing the name for them.

So I made a list :
{% for node in site.data.DNSrecord %}
 {% if node[1]['NS'] %}{% continue %}{% endif %}
- [{{ node[0] }}](//{{node[0]}}) {{ node[1]['_expires'] }} {% if node[1]['memo']['TXT'] %}
~~ [{{ node[1]['memo']['TXT'] }}]({{page.search_url}}={{ node[1]['memo']['TXT'] }})
{% endif %}
{% for sub in node[1] %}
  {% if sub[0] == '*' or sub[0] == 'memo' %}{% continue %}{% endif %}
  {% if sub[0] != '_contact' and sub[0] != '_secret' and sub[0] != '_expires' %}
  - {{ sub[0] }}
  {% endif %}
  {% for ip in sub[1]['A'] %}
    A {{ ip }}
  {% endfor %}
  {% if sub[1]['ALIAS'] %}
    ALIAS [{{ sub[1]['ALIAS'] }}](//{{ sub[1]['ALIAS'] }})
  {% elsif sub[1]['ANAME'] %}
    ANAME [{{ sub[1]['ANAME'] }}](//{{ sub[1]['ANAME'] }})
  {% endif %}
  {% if sub[0] == 'www' %}
    CNAME [{{ sub[1]['CNAME'] }}](//{{ sub[1]['CNAME'] }})
  {% elsif sub[0] == 'contact' %}
    RP {{ sub[1]['RP'] | replace_first: '.','@' }}
  {% endif %}
  {% for txt in sub[1]['TXT'] %}
  {% if sub[0] == 'registrar' %}
    TXT [{{ txt }}]({{ txt }})
  {% elsif sub[0] == '_dnslink' %}
    *DNS*link [{{ txt | replace: 'dnslink=','' }}]({{page.PGW}}{{ txt | replace: 'dnslink=','' }})
  {% elsif sub[0] == 'contact' %}
    <!-- TXT {{ txt }} -->
  {% else %}
    TXT {{ txt }}
  {% endif %}
  {% endfor %}
  {% endfor %}
{% endfor %}

I have 4 DNS providers :

{% for node in site.data.DNSrecord %}
   {% for sub in node[1] %}
     {% if sub[0] == 'NS' %}
 * [{{ node[0] }}](//{{node[0]}}) --
     {% for dns in sub[1] %}
        {{ dns }}
     {% endfor %}
     {% endif %}
   {% endfor %}
{% endfor %}










