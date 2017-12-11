-- q-data-types-create.sql
--
-- @author (c) Benjamin Brink
-- @creation-date 4 Dec 2017
-- @license: See spreadsheet/LICENSE.html
-- @for OpenACS.org
-- @cvs-id
--

CREATE SEQUENCE qt_id_seq start 100;
SELECT nextval ('qt_id_seq');


-- This began in the 1990s as Table Integrated Publishing System (tips)
-- for Ole Olesen of Olesen-Hunter Elevator using Excel macro language..
-- Adding to the "Q" 'branded' prefix packages on OpenACS suggests Q-TIPS
-- as a defacto name to use. To avoid trademark issues, using the more
-- generic q-tables instead.

-- This provides a way to override qt_data_types defaults locally.
CREATE TABLE qt_data_types (
       instance_id integer,
       -- Can be same as qt_data_types.label, if overrides an instance.
       type_name   varchar(40),
       -- Can map type_name to a different label..
       -- external key qdt_data_types.label
       qdt_label    varchar(40),
       -- data like, and overrides qdt_data_types.form_tag_attrs
       form_tag_attrs varchar(1000),
       -- ref that points to qt_field_values. f_vc1k, f_nbr or f_txt
       -- one of vc1k ,nbr or default to txt
       -- This can be overridden per qt_field_defs.field_type
       default_field_type varchar(5),
       empty_allowed_p boolean
);

create index qt_data_types_instance_id_idx on qt_data_types (instance_id);
create index qt_data_types_type_name_idx on qt_data_types (type_name);

-- define a table
CREATE TABLE qt_table_defs (
     instance_id integer,
     id          integer DEFAULT nextval ( 'qt_id_seq' ),
     label       varchar(40),
     name        varchar(40),
     -- for revision history
     user_id     integer,
     created     timestamptz default now(),
     flags       varchar(12),
     trashed_p   varchar(1),
     trashed_dt  timestamptz,
     trashed_by  integer
);

create index qt_table_defs_instance_id_idx on qt_table_defs (instance_id);
create index qt_table_defs_id_idx on qt_table_defs (id);
create index qt_table_defs_label_idx on qt_table_defs (label);
create index qt_table_defs_trashed_p_idx on qt_table_defs (trashed_p);

-- define fields for a table
CREATE TABLE qt_field_defs (
     instance_id integer,
     id          integer not null DEFAULT nextval ( 'qt_id_seq' ),
     table_id    integer not null,
     -- for revision history
     created     timestamptz default now(),
     user_id     integer,
     trashed_by  integer,
     trashed_p   varchar(1),
     trashed_dt  timestamptz,
     label       varchar(40),
     name        varchar(40),
     -- qt_field_values.fv is getting indexed
     default_val varchar(1025),
     -- qt_data_types.type_name
     tdt_data_type varchar(40),
     -- ref that points to qt_field_values. f_vc1k, f_nbr or f_txt
     -- one of vc1k ,nbr or default to txt
     -- This is added here as an override to 
     -- qt_data_types.default_field_type
     field_type  varchar(5)
);

create index qt_field_defs_instance_id_idx on qt_field_defs (instance_id);
create index qt_field_defs_id_idx on qt_field_defs (id);
create index qt_field_defs_table_id on qt_field_defs (table_id);
create index qt_field_defs_trashed_p on qt_field_defs (trashed_p);



-- for this to work reasonably,
-- queries should avoid sort
-- by using a matrix to collect data
-- and put into a list_of_lists
-- using an ordered table_list set of keys
-- or by putting into an array for single row
-- queries
CREATE TABLE qt_field_values (
    instance_id integer,
    table_id    integer not null,
    row_id      integer not null,
    trashed_p   varchar(1) default '0',
    trashed_by  integer,
    trashed_dt  timestamptz,
    -- created is same as last modified.
    -- each update creates a new record.
    created     timestamptz default now(),
    -- for revision history
    user_id     integer,
    -- from qt_field_defs.id
    field_id    integer,
    -- field value is put in one of these following fields
    -- depending on qt_field_defs.field_type
    --
    -- This is indexed, so limiting to 1025 length instead of text.
    -- f_txt and numeric are not indexed (yet)
    f_vc1k      varchar(1025),
    -- for numbers
    f_nbr       numeric,
    -- for general text content that is not indexed, sorted etc
    f_txt       text
);

create index qt_field_values_instance_id_idx on qt_field_values (instance_id);
create index qt_field_values_table_id_idx on qt_field_values (table_id);
create index qt_field_values_row_nbr_idx on qt_field_values (row_id);
create index qt_field_values_field_f_vc1k_idx on qt_field_values (f_vc1k);
create index qt_field_values_trashed_p_idx on qt_field_values (trashed_p);
