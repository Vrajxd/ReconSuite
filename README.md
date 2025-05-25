# ReconSuite

A modular, automated reconnaissance toolkit for domain and subdomain enumeration, alive host detection, vulnerability scanning, and directory brute forcing.

---

## Features

- Subdomain enumeration
- Alive subdomain detection
- Screenshot capturing of alive hosts
- Port scanning 
- Vulnerability scanning
- DNS information gathering
- Directory brute forcing
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
- chmod 777 reconsuite.sh
- ./reconsuite.sh example.com

- All output will be stored inside a folder named after the domain name , created within the ReconSuite directory.
