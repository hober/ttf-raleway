ROOT=ttf-raleway

ttf-raleway_001.000-1_all.deb: $(ROOT)/raleway_thin.otf $(ROOT)/OFL.txt
	cd $(ROOT) && debuild -us -uc

$(ROOT)/OFL.txt: $(ROOT)/Open\ Font\ License.txt
	cd $(ROOT) && cp "Open Font License.txt" OFL.txt

$(ROOT)/raleway_thin.otf $(ROOT)/Open\ Font\ License.txt: $(ROOT)/raleway.zip
	cd $(ROOT) && unzip -j raleway.zip "Raleway/$(@F)"

$(ROOT)/raleway.zip:
	cd $(ROOT) && curl -O http://s3.amazonaws.com/theleague-production/fonts/raleway.zip

install: ttf-raleway_001.000-1_all.deb
	dpkg -i ttf-raleway_001.000-1_all.deb

clean:
	rm -f ttf-raleway_001.* *~
	cd $(ROOT) && rm -f raleway_thin.otf *.txt raleway.zip
	cd $(ROOT)/debian && rm -rf ttf-raleway.debhelper.log ttf-raleway.substvars ttf-raleway/
