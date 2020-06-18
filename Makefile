# ETL pipeline for CPS LSCs

DATA_DIR := data
DATA_DIR_SRC := $(DATA_DIR)/source
DATA_DIR_HANDMADE := $(DATA_DIR)/handmade
DATA_DIR_PROCESSED := $(DATA_DIR)/processed
DATA_DIR_PUBLIC := $(DATA_DIR)/public

SHARED_DATA :=

include etl/lscs.mk
include etl/schools.mk

.PHONY: all

all: $(LSCS_DATA_DIR_PUBLIC)/members_school_details.csv $(LSCS_DATA_DIR_PUBLIC)/vacancies.csv

# Create directories for data

$(DATA_DIR_SRC):
	mkdir -p $@

$(DATA_DIR_HANDMADE):
	mkdir -p $@

$(DATA_DIR_PROCESSED):
	mkdir -p $@

$(DATA_DIR_PUBLIC):
	mkdir -p $@
