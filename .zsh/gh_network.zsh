alias edgerouter-ssh='ssh george@192.168.1.1'
alias edgerouter-failover-sensitivity-up='echo "configure"; echo "set load-balance group G interface pppoe0 route-test interval 5"; echo "commit; save; exit"; edgerouter-ssh'
alias edgerouter-failover-sensitivity-down='echo "configure"; echo "set load-balance group G interface pppoe0 route-test interval 10"; echo "commit; save; exit"; edgerouter-ssh'