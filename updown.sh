#!/bin/bash
# ----------------------
# called from strongswan
# ----------------------

VTI_IF="vti${PLUTO_UNIQUEID}"

case "$PLUTO_VERB:$1" in
up-client:)
    ip tunnel add "${VTI_IF}" local "${PLUTO_ME}" remote "${PLUTO_PEER}" mode vti key 100
    ip link set dev "${VTI_IF}" up
    # no policy
    sysctl -w net.ipv4.conf."${VTI_IF}".disable_policy=1
    sysctl -w net.ipv4.conf."${VTI_IF}".rp_filter=0
    # ip configuration and routing
    ip addr add "${PLUTO_MY_SOURCEIP}" dev "${VTI_IF}"
    ip route add "${PLUTO_PEER_CLIENT}"/32 dev "${VTI_IF}"
    ip route del default
    ip route add default dev "${VTI_IF}“ advmss 1400
    ;;
down-client:)
    ip tunnel del "${VTI_IF}"
esac
