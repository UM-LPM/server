# Monitoring server

Note: ```_gateway:9100``` is the host machine, not the gateway (which is  ```gateway:9100```).

## Connecting

To connect to the Prometheus or Graphana frontend: 
- forward the relevant port ```{{port}}``` to the local machine
- access it with the browser ```localhost:{{port}}```.

### Prometheus

```
ssh -L 9090:localhost:9090 monitor@prometheus
```

```
localhost:9090
```

### Grafana

```
ssh -L 3000:localhost:3000 monitor@prometheus
```

```
localhost:3000
```

The username is ```admin``` and the password is ```admin```, when asked to change the password press *skip*.
