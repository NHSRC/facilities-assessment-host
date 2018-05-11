#!/usr/bin/env bash
scp app-servers/keystore.p12 metabase/keystore.jks ~/.bashrc nhsrc2@10.31.37.24:/home/nhsrc2/backup/confbackup/
scp -r downloads/ nhsrc2@10.31.37.24:/home/nhsrc2/backup/binbackup/