#! /usr/bin/env bash

script_pwd="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"

immich_dir="$script_pwd"

dotenv_file="$immich_dir/.env"
dotenv_var='API_TOKEN'

immich_endpoint="http://localhost:3001"
token="$(sed -nE '/'"$dotenv_var"'/s/^'"$dotenv_var"'=//p' "$dotenv_file")"

import_dir="$immich_dir/import"

docker exec -it immich-server bash -c 'immich login '"$immich_endpoint"' '"$token"'; immich upload --recursive --album /import; immich logout'
