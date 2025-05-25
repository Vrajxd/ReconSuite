#!/bin/bash

RED="\033[1;31m"
RESET="\033[0m"

domain=$1
subdomain_path="$domain/sudomains"
screenshot_path="$domain/screenshots"
scan_path="$domain/scans"

# Check for domain input
if [ -z "$domain" ]; then
    echo -e "${RED}Usage: $0 <domain>${RESET}"
    exit 1
fi

# Create directory structure
setup_dirs() {
    mkdir -p "$subdomain_path" "$screenshot_path" "$scan_path"
}

run_subdomain_enum() {
    echo -e "${RED} [+] Running subdomain enumeration... ${RESET}"
    subfinder -d "$domain" > "$subdomain_path/found.txt"
    assetfinder "$domain" | grep "$domain" >> "$subdomain_path/found.txt"
}

find_alive_subdomains() {
    echo -e "${RED} [+] Finding alive subdomains with httpx... ${RESET}"
    cat "$subdomain_path/found.txt" | sort -u | httpx -silent -status-code -title -tech-detect -no-color -json > "$subdomain_path/httpx.json"
    jq -r 'select(.url | contains("https://")) | .url' "$subdomain_path/httpx.json" | sed 's|https\?://||' > "$subdomain_path/alive.txt"
}

take_screenshots() {
    echo -e "${RED} [+] Taking screenshots of alive subdomains... ${RESET}"
    gowitness file -f "$subdomain_path/alive.txt" -P "$screenshot_path/" --no-http
}

run_nmap() {
    echo -e "${RED} [+] Running Nmap scan... ${RESET}"
    nmap -iL "$subdomain_path/alive.txt" -T4 -p- -oN "$scan_path/nmap.txt"
}

run_nuclei() {
    echo -e "${RED} [+] Running Nuclei scan... ${RESET}"
    nuclei -l "$subdomain_path/alive.txt" -o "$scan_path/nuclei.txt" -silent
}

run_dnsrecon() {
    echo -e "${RED} [+] Running DNSRecon... ${RESET}"
    dnsrecon -d "$domain" -a -b -n 1.1.1.1 > "$scan_path/dnsrecon.txt"
}

run_ffuf() {
    echo -e "${RED} [+] Running directory brute-force (ffuf)... ${RESET}"
    while read -r url; do
        ffuf -u "https://$url/FUZZ" -w /usr/share/wordlists/dirbuster/directory-list-2.3-small.txt -o "$scan_path/ffuf-$url.json" -of json
    done < "$subdomain_path/alive.txt"
}

show_menu() {
    echo -e "\n${RED}--- Recon Script Menu ---${RESET}"
    echo "1) Setup directories"
    echo "2) Subdomain Enumeration"
    echo "3) Find Alive Subdomains"
    echo "4) Take Screenshots"
    echo "5) Run Nmap"
    echo "6) Run Nuclei"
    echo "7) Run DNSRecon"
    echo "8) Run ffuf (Directory Bruteforcing)"
    echo "9) Run Full Recon"
    echo "0) Exit"
}

run_all() {
    setup_dirs
    run_subdomain_enum
    find_alive_subdomains
    take_screenshots
    run_nmap
    run_nuclei
    run_dnsrecon
    run_ffuf
}

# Script entry point
setup_dirs

while true; do
    show_menu
    read -p "Choose an option: " opt
    case $opt in
        1) setup_dirs ;;
        2) run_subdomain_enum ;;
        3) find_alive_subdomains ;;
        4) take_screenshots ;;
        5) run_nmap ;;
        6) run_nuclei ;;
        7) run_dnsrecon ;;
        8) run_ffuf ;;
        9) run_all ;;
        0) echo "Exiting." && exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
