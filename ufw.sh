#!/usr/bin/env bash

# Skrypt: ufw.sh
# Opis:   Konfiguracja zapory sieciowej UFW

set -euo pipefail

# sprawdzenie roota
if [ "$EUID" -ne 0 ]; then
    echo "[-] Uruchom ten skrypt jako root lub z sudo: sudo $0"
    exit 1
fi

echo "[+] 1. Instalacja / weryfikacja pakietu ufw"
apt-get update -y
apt-get install -y ufw

echo "[+] 2. Resetowanie konfiguracji do stanu domyślnego"
ufw --force reset

echo "[+] 3. Ustawianie domyślnych polityk"
ufw default deny incoming
ufw default allow outgoing

echo "[+] 4. Zezwalanie na SSH"
ufw limit 22/tcp comment 'SSH'

echo "[+] 5. Konfiguracja logowania zdarzeń zapory"
ufw logging medium

echo "[+] 6. Aktywacja zapory UFW"
ufw --force enable

echo "Status zapory sieciowej:"
ufw status verbose

echo "[i] Logi zapory w: /var/log/ufw.log lub przez journalctl -u ufw"
