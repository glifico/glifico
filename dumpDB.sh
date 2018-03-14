#!/bin/bash
export host=ec2-54-247-81-76.eu-west-1.compute.amazonaws.com
export user=rxalpunoeboees
export db=d36l13eln0ugr5
export filename=glifico.sql
rm -f $filename
echo "You will be asked password for remote db:"
pg_dump -h $host -U $user $db --format=plain --no-owner -v >> $filename
#pg_dump -h $host -U $user $db --no-owner -v >> $filename


#git diff $filename
# git add *.sql
# git commit -m "dump DB"
