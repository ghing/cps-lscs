# Chicago Public Schools Local School Councils

Compile data on Chicago Public Schools Local School Council memberships and vacancies

*Created by Geoff Hing (<geoffhing@gmail.com>)*

*Reporter: Geoff Hing (<geoffhing@gmail.com>)*

## Project goal

*TK: Briefly describe this project*

## Project notes

### Data sources

- 2019 LSC Members Map
  - URL: https://cps.edu/ScriptLibrary/Map-LSCMembers2018/index.html
  - Agency: Chicago Public Schools

## Technical

### Assumptions

- GNU Make
- jq
- csvkit

### Project setup instructions

*TK: For more complex or unusual projects additional directions follow*

### Building the data

To build the data in `data/lscs/public`, run:

```
make
```

TODO: Properly escape the jq commands so they work correctly in the Makefile to convert JSONP responses to JSON.

## Data notes

The vintage of the LSC member data is unclear. The map title says 2019, the URL slug says 2018 and the API endpoint parameter is 2018.
