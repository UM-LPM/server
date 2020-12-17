#Firewall

```
-A INPUT -i vprivate -p udp --dport 9100 -j ACCEPT
-A INPUT -i vprivate -p tcp --dport 9100 -j ACCEPT
-A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m tcp --syn -m conntrack --ctstate NEW --dport 12022 -j ACCEPT
-A INPUT -p icmp --icmp-type 8 -m conntrack --ctstate NEW -j ACCEPT
-A INPUT -p tcp -j REJECT --reject-with tcp-reset
-A INPUT -p udp -j REJECT --reject-with icmp-port-unreachable
-A INPUT -j REJECT --reject-with icmp-proto-unreachable
```
