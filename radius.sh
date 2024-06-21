#!/bin/ash

######## CONFIG SECTION BEGIN ########

RADIUS_SERVER=""
RADIUS_SECRET=""
RADIUS_PORT=1812
USERNAME=""
PASSWORD=""
AUTH_RATE=200  # Authentications per second
CONFIG_FILENAME="eapol_test.conf"
TIMEOUT=30  # Timeout in seconds

######## CONFIG SECTION END ########

generate_random_mac() {
        od -An -N6 -tx1 /dev/urandom | tr ' ' '\n' | grep -v '^$' | paste -sd ':' -
}

create_eapol_test_config() {
    cat <<EOF > $CONFIG_FILENAME
network={
    ssid="ExampleSSID"
    key_mgmt=WPA-EAP
    eap=PEAP
    identity="$USERNAME"
    password="$PASSWORD"
    phase1="peaplabel=0"
    phase2="auth=MSCHAPV2"
}
EOF
}

send_eapol_test_request() {
    local mac=$(generate_random_mac)
    timeout $TIMEOUT eapol_test -t 30 -r 3 -c $CONFIG_FILENAME -s $RADIUS_SECRET -a $RADIUS_SERVER -p $RADIUS_PORT -M $mac /dev/null 2>&1 &
}

main() {
    create_eapol_test_config
    local delay=$(echo "scale=6; 1 / $AUTH_RATE" | bc)

    while true; do
        send_eapol_test_request
        sleep $delay
    done
}

main