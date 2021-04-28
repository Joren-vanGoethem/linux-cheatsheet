#!/bin/bash
sudo iptables -D INPUT -j DROP
sudo iptables -D OUTPUT -j DROP
sudo iptables -D FORWARD -j DROP
sudo iptables -A INPUT -j DROP
sudo iptables -A OUTPUT -j DROP
sudo iptables -A FORWARD -j DROP