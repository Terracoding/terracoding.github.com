---
layout: default
---
{% include JB/setup %}

<div class="row">
  <div class="span8">
    {% for post in site.posts limit:10 %}
    <div class='project'>
      <div class="post-header">
        <h1>{{ post.title }}</h1>
        <div class="page-detail">{{ post.date | date_to_string }}</div>
      </div>
      <p>{{ post.content | strip_html | truncatewords: 50 }}</p>  
      <p><a class="btn btn-primary" href="{{ post.url }}">Read More &raquo;</a></p>
    </div>
  {% endfor %}
  </div>
  <div class="span3">
    <h2>Archive</h2>
    <ul class="posts">
      {% for post in site.posts limit:10 %}
        <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
      {% endfor %}
    </ul>
  </div>
</div>