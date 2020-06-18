# ETL pipeline for CPS schools

SCHOOLS_DATA_DIR_SRC := $(DATA_DIR_SRC)/schools
SCHOOLS_DATA_DIR_MANUAL := $(DATA_DIR_MANUAL)/schools
SCHOOLS_DATA_DIR_PROCESSED := $(DATA_DIR_PROCESSED)/schools
SCHOOLS_DATA_DIR_PUBLIC := $(DATA_DIR_PUBLIC)/schools

SCHOOLS_SHARED_DATA :=

# Download schools from the LSC map API
$(SCHOOLS_DATA_DIR_SRC)/schools.json: | $(SCHOOLS_DATA_DIR_SRC)
	curl -o $@ https://api.cps.edu/maps/LSC/GeoJSON?mapName=school&year=2020

# Create directories for data

$(SCHOOLS_DATA_DIR_SRC):
	mkdir -p $@

$(SCHOOLS_DATA_DIR_MANUAL):
	mkdir -p $@

$(SCHOOLS_DATA_DIR_PROCESSED):
	mkdir -p $@

$(SCHOOLS_DATA_DIR_PUBLIC):
	mkdir -p $@
