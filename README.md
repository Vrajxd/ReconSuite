# ReconSuite

A modular, automated reconnaissance toolkit for domain and subdomain enumeration, alive host detection, vulnerability scanning, and directory brute forcing.

---

## Features

- Subdomain enumeration using tools like `subfinder` and `assetfinder`
- Alive subdomain detection with `httpx`
- Screenshot capturing of alive hosts via `gowitness`
- Port scanning using `nmap`
- Vulnerability scanning with `nuclei`
- DNS information gathering through `dnsrecon`
- Directory brute forcing with `ffuf`
- Modular design with interactive menu or full automation

---

## Installation

Make sure the following dependencies are installed and available in your system PATH:

- [subfinder](https://github.com/projectdiscovery/subfinder)
- [assetfinder](https://github.com/tomnomnom/assetfinder)
- [httpx](https://github.com/projectdiscovery/httpx)
- [gowitness](https://github.com/sensepost/gowitness)
- [nmap](https://nmap.org/)
- [nuclei](https://github.com/projectdiscovery/nuclei)
- [dnsrecon](https://github.com/darkoperator/dnsrecon)
- [ffuf](https://github.com/ffuf/ffuf)
- [jq](https://stedolan.github.io/jq/)

---

## Usage

- sudo apt update && sudo apt upgrade
- git clone https://github.com/Vrajxd/ReconSuite
- cd ReconSuite
- ./reconsuite.sh example.com
