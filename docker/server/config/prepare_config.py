#!/usr/bin/env python3
import os.path
from os import path
import json

def prepare_tso(fdb_cluster_filename):
    fdb_cluster_file_place_holder = 'CLUSTER_FILE_PLACE_HOLDER'
    with open(r'config/tso_template.xml', 'r') as file:
        data = file.read()
        data = data.replace(fdb_cluster_file_place_holder, fdb_cluster_filename)

    with open(r'config/tso.xml', 'w') as file:
        file.write(data)

def main():
    if not path.exists("./config/fdb.cluster"):
        print("Error: ./config/fdb.cluster is not exist!")
        return

    config_file = open('config.json')
    input_config = json.load(config_file)
    #fdb_cluster_file = input_config["foundation_db_cluster_file"]

    #prepare_tso(fdb_cluster_file)

if __name__ == "__main__":
    main()

