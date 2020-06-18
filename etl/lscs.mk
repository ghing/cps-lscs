# ETL pipeline for Local School Councils

LSCS_DATA_DIR_SRC := $(DATA_DIR_SRC)/lscs
LSCS_DATA_DIR_MANUAL := $(DATA_DIR_MANUAL)/lscs
LSCS_DATA_DIR_PROCESSED := $(DATA_DIR_PROCESSED)/lscs
LSCS_DATA_DIR_PUBLIC := $(DATA_DIR_PUBLIC)/lscs

LSCS_SHARED_DATA :=

# Join school name, address, etc from vacancies to members
$(LSCS_DATA_DIR_PUBLIC)/members_school_details.csv: $(LSCS_DATA_DIR_PROCESSED)/members.csv $(LSCS_DATA_DIR_PROCESSED)/vacancies.csv | $(LSCS_DATA_DIR_PUBLIC)
	csvjoin -c SchoolId --left $^ | csvcut -c SchoolId,LSCMemberType,MemberName,SchoolName,Address,Phone,SchoolType > $@

# Just copy the vacancies CSV to the public folder with no further processing
# (for now).
$(LSCS_DATA_DIR_PUBLIC)/vacancies.csv: $(LSCS_DATA_DIR_PROCESSED)/vacancies.csv | $(LSCS_DATA_DIR_PUBLIC)
	cp $< $@

# Turn JSON into CSV
$(LSCS_DATA_DIR_PROCESSED)/members.csv: $(LSCS_DATA_DIR_PROCESSED)/members.json
	in2csv $< > $@

$(LSCS_DATA_DIR_PROCESSED)/vacancies.csv: $(LSCS_DATA_DIR_PROCESSED)/vacancies.json
	in2csv $< > $@

# Turn JSONP response into JSON
# Recipe from the jq FAQ: https://github.com/stedolan/jq/wiki/FAQ#general-questions
# TODO: Figure out why this doesn't work. Probably escaping.
# Running the command on the command line works.
$(LSCS_DATA_DIR_PROCESSED)/members.json: $(LSCS_DATA_DIR_SRC)/members.js | $(LSCS_DATA_DIR_PROCESSED)
	jq -R 'capture("\\((?<x>.*)\\)[^)]*$").x | fromjson' $< > $@

$(LSCS_DATA_DIR_PROCESSED)/vacancies.json: $(LSCS_DATA_DIR_SRC)/vacancies.js | $(LSCS_DATA_DIR_PROCESSED)
	jq -R 'capture("\\((?<x>.*)\\)[^)]*$").x | fromjson' $< > $@

# Download LSC members from the API that feeds the LSC map
$(LSCS_DATA_DIR_SRC)/members.js: | $(LSCS_DATA_DIR_SRC)
	curl -o $@ https://secure.cps.edu/json/lsc/GetLSCMembers?year=2018&callback=jQuery111104536680941886255_1592428350019&_=1592428350020

# Download LSC vacancies from the LSC map
$(LSCS_DATA_DIR_SRC)/vacancies.js: | $(LSCS_DATA_DIR_SRC)
	curl -o $@ https://secure.cps.edu/json/lsc/getlscvacancies?year=2020&callback=jQuery111104536680941886255_1592428350017&_=1592428350018

# Create directories for data

$(LSCS_DATA_DIR_SRC):
	mkdir -p $@

$(LSCS_DATA_DIR_MANUAL):
	mkdir -p $@

$(LSCS_DATA_DIR_PROCESSED):
	mkdir -p $@

$(LSCS_DATA_DIR_PUBLIC):
	mkdir -p $@
