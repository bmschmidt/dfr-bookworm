#this one is redundant, but just for clarity:
jsoncatalog.txt:
	python makeJsonCatalog.py > $@

#### Here's the stuff that makes the BookwormDB

unigrams.txt:
	-rm -f $@
	mkfifo $@
	python makeUnigrams.py > unigrams.txt &

BookwormDB:
	git clone git@github.com:Bookworm-Project/BookwormDB BookwormDB
	mkdir -p $@/files
	mkdir -p $@/files/metadata
	mkdir -p $@/files/texts

BookwormDB/files/metadata/jsoncatalog.txt: jsoncatalog.txt
	cp $< $@

BookwormDBdatabase: BookwormDB BookwormDB/files/texts/input.txt BookwormDB/files/metadata/jsoncatalog.txt
	cd BookwormDB; git checkout master
	cd BookwormDB; python scripts/guessAtDerivedCatalog.py
	cd BookwormDB; make all


### And some cleaning methods

clean:
	rm input.txt
	rm jsoncatalog.txt

cleanBookwormDB:
	rm -f BookwormDB/files/texts/input.txt
	rm -f BookwormDB/files/texts/metadata/jsoncatalog.txt
	rm -f BookwormDB/files/texts/metadata/field_descriptions.json
	cd BookwormDB; make clean;
