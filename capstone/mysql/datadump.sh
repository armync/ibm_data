#!/bin/bash

mysqldump -u "root" -p"pass" "sales" "sales_data" >  "sales_data.sql"
