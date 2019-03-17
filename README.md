# docker-fluentd-elasticsearch
Fluentd data collector with Elasticsearch output plugin 

## Fluentd

Fluentd is an open source data collector, which lets you unify the data collection and consumption for a better use and understanding of data.

[Read more](https://hub.docker.com/r/fluent/fluentd)

## Usage

Running the logdriver:

```
$ docker run -it -p 24224:24224 \
  -v /root/fluentd/custom-fluentd/fluent-elasticsearch-s3.conf:/fluentd/etc/fluent.conf \
  -e FLUENTD_CONF=fluent.conf \
  ruanbekker/fluentd-with-plugins
```

Let application write to the logdriver:

```
$ docker run -itd --name nginxweb --log-driver=fluentd -p 80:80 nginx
```

Make a request to nginx: 

```
$ curl -H "Host: example.com" \
  -A "Chrome/5.0 (iPhone; U; CPU iPhone OS 5_1_2 like Mac OS X; en-us) AppleWebKit/533.18.0 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5" \
  http://endpoint-to-container:80
```

Look at the elasticsearch index:

```
$ curl 'https://es.domain.com/fluentd-2019.03.15/_search?pretty&size=1'
{
  "took" : 3,
  "timed_out" : false,
  "_shards" : {
    "total" : 5,
    "successful" : 5,
    "skipped" : 0,
    "failed" : 0
  },
  "hits" : {
    "total" : 85,
    "max_score" : 1.0,
    "hits" : [
      {
        "_index" : "fluentd-2019.03.15",
        "_type" : "fluentd",
        "_id" : "anDrf2kBBayzo6nbSVOZ",
        "_score" : 1.0,
        "_source" : {
          "container_id" : "09dde7de5554788ea8bed7cd6302c859c7f894014a657ebb7631c69fb95e6ff8",
          "container_name" : "/nginxweb",
          "source" : "stdout",
          "log" : "10.20.30.40 - - [15/Mar/2019:05:55:18 +0000] \"GET / HTTP/1.1\" 200 612 \"-\" \"Mozilla/5.0 (Android; U; CPU Android OS 5 like Linux; en-us) AndroidWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8J2 Safari/6533.18.5\" \"-\"",
          "@timestamp" : "2019-03-15T05:55:18.000000000+00:00"
        }
      }
    ]
  }
}
```

## Resources

- [Fluentd Docs](https://docs.fluentd.org/v1.0/articles/config-file)
- [Fluentd with Docker](https://docs.fluentd.org/v0.12/articles/install-by-docker)
- [Fluentd with S3/ES](https://www.fluentd.org/guides/recipes/elasticsearch-and-s3)
- [Fluentd ES Plugin](https://github.com/uken/fluent-plugin-elasticsearch)
- [Fluentd with Pushover Notifications](https://github.com/Berndinox/fluentd-pushover)
