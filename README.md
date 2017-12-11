Q-Tables
========

For the latest updates to this readme file, see: http://openacs.org/xowiki/q-tables

The latest version of the code is available at the development site:
 http://github.com/tekbasse/q-tables

introduction
------------

Q-Tables provides procedures for importing, exporting data, customizing
dynamic q-forms forms and generally manipulating tables with fuzzy data
in OpenACS.


license
-------
Copyright (c) 2013 Benjamin Brink
po box 193, Marylhurst, OR 97036-0193 usa
email: tekbasse@yahoo.com

Spreadsheet is open source and published under the GNU General Public License, consistent with the OpenACS system: http://www.gnu.org/licenses/gpl.html
A local copy is available at spreadsheet/LICENSE.html

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

features
--------

Integrates with Q-Forms or any table processing paradigm.

Can manipulate Tcl list of lists for easy generation of reports.

Q-Tables API is an OpenACS implemenetation of  
TIPS "Table Integrated Publishing System", a database
paradigm used extensively for developing data models in flux 
and importing or converting databases from one format to another.
It was first developed in the 1990's.


TIPS System and Q-Tables API
--------

The API is based on the flexibility of spreadsheets, where:

*   There is no difference between a cell with null or empty string value.

*   There are only 3 "formula" types, numeric, text and vc1k (varchar(1025)).

*   Any type can have an empty value.

*   A vc1k declared column can be referenced by first or most recent, 
    or all cases of search-string. Foreign Keys are not constrained.

*   A missing key returns an empty row/cell. In essence code level errors are avoided.

*   Data updates can be by row or cell or column.

*   Unreferenced columns are ignored or "hidden". 

*   All columns are assumed if none referenced.

*   Rows and columns are referenced by internal row_id and field_id (column) or field/column "label".

*   Tables can be imported from most any paradigm without concern of errors due to input restrictions from inconsistent data.

Revisioning is trackable per cell and timestamp, for implementing an "undo" or revisioning capability.

