# ambry-docker
Dockerized linkedin's ambry

Ambry is a distributed object store that supports storage of trillion of small immutable objects (50K -100K) as well as billions of large objects. It was specifically designed to store and serve media objects in web companies. However, it can be used as a general purpose storage system to store DB backups, search indexes or business reports. The system has the following characterisitics:

Highly available and horizontally scalable
Low latency and high throughput
Optimized for both small and large objects
Cost effective
Easy to use
Requires at least JDK 1.8.

RUN:

`docker run -p 1174:1174 maciejbak85/ambry:1.0`

Check health:
`curl http://localhost:1174/healthCheck
GOOD`

Upload image:
`curl -i -H "x-ambry-blob-size : ``wc -c a.jpg | xargs | cut -d" " -f1``" -H "x-ambry-service-id : CUrlUpload"  -H "x-ambry-owner-id : `whoami`" -H "x-ambry-content-type : image/gif" -H "x-ambry-um-description : Demonstration Image" http://localhost:1174/ --data-binary @a.jpg
HTTP/1.1 201 Created
Location: /AAEAAQAAAAAAAAAAAAAAJDE1MDA3NWU0LTQxN2MtNGM5MC1hMTdlLWM2MmQ5YWVjNDQ5ZQ
Date: Mon, 28 Aug 2017 17:34:49 GMT
Content-Length: 0
x-ambry-creation-time: Mon, 28 Aug 2017 17:34:47 GMT`


