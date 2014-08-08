# Docker Puppet + RTC

Create a docker container with a puppet agent and Remote Team Concert installed.
(based on docker-puppet-master-agent)

Build :
````
docker build --rm=true -t rtc-agent .
```

To launch and link to a container named *master* running a puppetmaster:
```
docker run -d -P --link master:master --name rtc-agent rtc-agent
```

To run without puppetmaster:
```
docker run -d -P --name rtc-agent rtc-agent
```

Check :
```
docker ps
```
Remember port to connect : ```0.0.0.0:49166->22/tcp```

Connect with ssh :
```
ssh root@localhost -p 49165
```

Password to log in is *root*.
