-- q-data-types-drop.sql
--
-- @author (c) Benjamin Brink
-- @creation-date 4 Dec 2017
-- @license: See spreadsheet/LICENSE.html
-- @for OpenACS.org
-- @cvs-id
--

drop index qt_field_values_trashed_p_idx;
drop index qt_field_values_field_f_vc1k_idx;
drop index qt_field_values_row_nbr_idx;
drop index qt_field_values_table_id_idx;
drop index qt_field_values_instance_id_idx;
DROP TABLE qt_field_values;

drop index qt_field_defs_trashed_p;
drop index qt_field_defs_table_id;
drop index qt_field_defs_id_idx;
drop index qt_field_defs_instance_id_idx;
DROP TABLE qt_field_defs;

drop index qt_table_defs_trashed_p_idx;
drop index qt_table_defs_label_idx;
drop index qt_table_defs_id_idx;
drop index qt_table_defs_instance_id_idx;
DROP TABLE qt_table_defs;

drop index qt_data_types_type_name_idx;
drop index qt_data_types_instance_id_idx;
DROP TABLE qt_data_types;

DROP SEQUENCE qt_id_seq;

