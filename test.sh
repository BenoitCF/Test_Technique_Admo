#!/bin/bash 

# directory to put the backup files
BACKUP_DIR=/Users/test/backup_db

# MYSQL Parameters to have admin access
MYSQL_UNAME=root
MYSQL_PWORD=root

# Don't backup databases with these names 
# Example: starts with mysql (^mysql) or ends with _schema (_schema$)
IGNORE_DB="(^mysql|_schema$)"


# YYYY-MM-DD
TIMESTAMP=$(date +%F)


function mysql_login() {
  local mysql_login="-u $MYSQL_UNAME" 
  if [ -n "$MYSQL_PWORD" ]; then
    local mysql_login+=" -p$MYSQL_PWORD" 
  fi
  echo $mysql_login
}

function database_list() {
  local show_databases_sql="SHOW DATABASES WHERE \`Database\` NOT REGEXP '$IGNORE_DB'"
  echo $(mysql $(mysql_login) -e "$show_databases_sql"|awk -F " " '{if (NR!=1) print $1}')
}

function echo_status(){
  printf '\r'; 
  printf ' %0.s' {0..100} 
  printf '\r'; 
  printf "$1"'\r'
}

function backup_database(){
    backup_file="$BACKUP_DIR/$TIMESTAMP.$database.sql.gz" 
    output+="$database => $backup_file\n"
    echo_status "...backing up $count of $total databases: $database"
    $(mysqldump $(mysql_login) $database | gzip -9 > $backup_file)
}

function backup_databases(){
  local databases=$(database_list)
  local total=$(echo $databases | wc -w | xargs)
  local output=""
  local count=1
  for database in $databases; do
    backup_database
    local count=$((count+1))
  done
  echo -ne $output | column -t
}

function hr(){
  printf '=%.0s' {1..100}
  printf "\n"
}

#==============================================================================
# RUN SCRIPT
#==============================================================================

backup_databases
hr
printf "All backed up!\n\n"


## on ping une adresse ip pour trouver la machine réceptrice 

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
  echo "connection is OK"
else
  echo "Error, there's no connection"
fi

#initialisation d'une variable erreur pour envoyer un mail 
r=0 

## après avoir pingé une premiere fois on fais les tests pour envoyer le fichier 

for ((i=0 ; $i<50 ; i++)) 
    do 
        if [ ping -W 1 8.8.8.8 &>/dev/null ]; then
            scp $backup_file 8.8.8.8:/remote/directory
            echo "Host Found, File transfered"
            $r=1 
            break 
          else 
            sleep 30 
            echo "Ping Fail";
            $i= $((i+1));
            $r=0
            continue 
        fi  
done

if [ $r = 0 ] 
  then 
  #il faut que un utilitaire de mail soit installé sur la machine précedemment 
  #on pourra alors utilisé la commande mail comme suis
  mail -s "Alert message" bcf97113@gmail.com <<< "The host was not found, transfer abort"
fi 

exit 0  

### End of script ####
