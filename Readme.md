# Docker Puppet + Jazz SCM

Create a docker container with a puppet agent and Jazz SCM (lscm) installed.
(based on docker-puppet-master-agent https://github.com/vvision/docker-puppet-master-agent)

Build :
````
docker build --rm=true -t jazz-agent .
```

To launch and link to a container named *master* running a puppetmaster:
```
docker run -d -P --link master:master --name jazz-agent jazz-agent
```

To run without puppetmaster:
```
docker run -d -P --name jazz-agent jazz-agent
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
