# Monitoring server

## Connecting

To connect to the Prometheus or Graphana frontend: 
- forward the relevant port ```{{port}}``` to the local machine
- access it with the browser ```localhost:{{port}}```.

### Prometheus

```
ssh -L 9090:localhost:9090 prometheus@prometheus
```

```
localhost:9090
```

### Grafana

```
ssh -L 3000:localhost:3000 prometheus@prometheus
```

```
localhost:3000
```

The username is ```admin``` and the password is ```admin```, when asked to change the password press *skip*.
