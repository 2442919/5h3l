#!/bin/bash

# Funcția care verifică dacă un proces este activ
is_process_running() {
    local script_name=$1
    pgrep -f "$script_name" > /dev/null 2>&1
}

# Funcția care repornește scriptul
restart_script() {
    local script_path=$1
    local copy_script_path="${script_path}.copy"
    
    # Creează o copie a scriptului
    cp "$script_path" "$copy_script_path"
    
    # Repornește scriptul copiat
    nohup bash "$copy_script_path" > /dev/null 2>&1 &
}

# Citirea numelui scriptului de monitorizat
read -p "Introduceți numele scriptului de monitorizat (inclusiv extensia .sh): " script_name

# Verifică dacă scriptul există
if [[ ! -f "$script_name" ]]; then
    echo "Scriptul $script_name nu există."
    exit 1
fi

echo "Monitorizez scriptul $script_name..."

# Monitorizează scriptul
while true; do
    if ! is_process_running "$script_name"; then
        echo "Procesul $script_name nu este activ. Se repornește scriptul."
        restart_script "$script_name"
    else
        echo "Procesul $script_name este în execuție."
    fi
    sleep 5  # Verifică la fiecare 5 secunde
done
