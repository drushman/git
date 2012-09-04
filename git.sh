#!/bin/sh

# Configuration:



BACKUP_DIRECTORY="/var/backup"
DRUPAL_ROOT='dirname $0'


#_now=$(date +"%m_%d_%Y")
echo "$DRUPAL_ROOT"
cd $0
exit;
if [ ! -d "$BACKUP_DIRECTORY.git" ]
then
   cd $BACKUP_DIRECTORY	
   git init 
   echo -n "please input link remote on your Repository:" 
   cd $DRUPAL_ROOT
   read link
	#else
   #rm .git
fi


for site in $( ls "$DRUPAL_ROOT/sites" )
do
  site_path="$DRUPAL_ROOT/sites/$site"

  # Selects directories which contain settings.php (excluding symbolic links)
  if [ -d $site_path -a -f "$site_path/settings.php"  -a ! -L $site_path ]; then
    echo "Dumping database for $site"
    drush -r $site_path sql dump --ordered-dump --structure-tables-key=structure-tables > "$BACKUP/database/$site.sql"
    echo "Done"
  fi
done


#git remote add origin $link
#START=`date +'%m-%d-%Y %H:%M:%S'`
#now = $(date +"%m-%d-%Y")
#mysqldump -u$DATABASE_USERNAME -p$DATABASE_PASSWORD \
 #          --single-transaction --add-drop-table \
  #         $DATABASE > $DATABASE.sql
#drush sql-dump --result-file=$BACKUP_DIRECTORY/db.sql
#echo '$BACKUP_DIRECTORY/db.sql'

#echo $NOW
git add .
git commit -m "update this .$_now"
git remote add origin $link

git push -u origin master


#END=`date +'%m-%d-%Y %H:%M:%S'`
#CHANGES=`git diff --stat`
#SIZE=`ls -lh $DATABASE.sql | awk '{print $5}'`

#/usr/bin/git-commit -v -m "Started:  $START
#Finished: $END
#File size: $SIZE
#$CHANGES" -v $DATABASE.dump
