import json
import os
import warnings

for file in os.listdir("dfr-files"):
    try:
        input = open("dfr-files/" + file + "/citations.tsv")
    except:
        print "There are no citations files in the directory %s" %file
        raise
    headers = input.readline().rstrip("\n").split("\t")
    for line in input:
        line = line.rstrip("\n")
        entry = dict(zip(headers,line.split("\t")))
        entry['filename'] = entry['id']
        print json.dumps(entry)
