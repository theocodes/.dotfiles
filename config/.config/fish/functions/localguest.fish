function localguest
    cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'
end
