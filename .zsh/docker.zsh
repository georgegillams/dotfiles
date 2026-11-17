alias docker-reset='docker ps -a -q | xargs -L1 docker rm --force'
alias docker-reset-prune='docker system prune -a -f'
alias docker-reset-images='docker ps -a -q | xargs -L1 docker rmi --force'
alias docker-reset-hard='docker-reset && docker-reset-images && docker-reset-prune'
alias docker-list-processes='docker ps -a'
alias docker-list-ips='docker inspect -f "{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq)'
alias docker-list-ports='docker inspect --format="{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}" $(docker ps -aq)'
alias docker-start-all='docker start $(docker ps -aq)'
alias docker-pull-sql-image='docker pull microsoft/mssql-server-linux:2017-latest'

# Removes all containers, pods, images, volumes, networks and build cache,
# but keeps the podman machine
function podman-reset() {
  podman rm --all --force
  podman pod rm --all --force
  podman rmi --all --force
  podman system prune --all --volumes --force
}

# Wipes all podman storage, including podman machines (the VM disk images)
alias podman-reset-hard='podman system reset --force'

