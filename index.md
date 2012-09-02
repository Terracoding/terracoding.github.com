---
layout: default
---
{% include JB/setup %}

{% for post in site.posts limit:10 %}

## {{ post.title }}
{{ post.date | date_to_string }}

{{ post.content | strip_html | truncatewords: 50 }} 

<a class="btn primary" href="{{ post.url }}">Read More &raquo;</a>

---
{% endfor %}

## Archive

<ul class="posts">
  {% for post in site.posts limit:10 %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>

