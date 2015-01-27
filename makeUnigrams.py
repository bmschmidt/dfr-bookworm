import json
import os
import warnings
import re



def unigramFiles():
    for file in os.listdir("dfr-files"):    
        for unigramList in os.listdir("dfr-files/" + file + "/wordcounts"):
            id = re.sub(r".*_([0-9\.]+)_([0-9]+).*",r"\1/\2",unigramList)
            yield( ("/".join(["dfr-files",file,"wordcounts",unigramList]),id))


for file in unigramFiles():
    reading = open(file[0])
    reading.readline()
    for line in reading:
        line = line.rstrip("\n")
        line = "\t".join(line.split(","))
        print "%s\t%s" % (file[1],line)
        
