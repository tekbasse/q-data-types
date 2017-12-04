-- q-data-types-create.sql
--


CREATE TABLE qt_data_types (
       -- unique reference
       label  varchar(40),
       -- one of text, list, array_list, clock, decimal, integer, boolean
       -- where clock is time since epoch in seconds
       tcl_type varchar(12),
       max_length  integer,
       -- When used with a form, this is default tag to use:
       -- from q-forms: input, textarea, 
       -- and q-forms specific help types: choice, choices
       form_tag_type varchar(12),
       -- default attributes and their values to include with html tag.
       -- for example, if type is 'input', this might contain 'maxlength 10'
       -- for an input with maxlength of 10 characters.
       form_tag_attrs varchar(1000),
       empty_allowed_p boolean,
       -- A string displayed to hint at expected input format.
       input_hint varchar(100),
       -- Name of procedure to validate info.
       -- Validation does not necessarily consider empty case.
       -- validation procedure name (referenced by tcl switch)
       text_format_proc varchar(40),
       -- string for use with tcl format command
       tcl_format_str varchar(40),
       -- string for use with tcl clock format value -format string
       tcl_clock_format_str varchar(60),
       valida_proc varchar(40),
       css_span varchar(120),
       css_div varchar(120),
       -- Use in an html STYLE tag as in <style = "html_style.value">
       -- This may be used with a css tag if need be.
       html_style varchar(120)
       -- If abbreviation of data required for display etc, use this proc
       -- to abbreviate into a text-only format
       abbrev_proc varchar(40),
       -- If a proc is required to create a formal format
       -- use this proc to generate the text portion.
       css_abbrev varchar(120),
       -- If an abbrev format is displayed, use this inside an html SPAN tag
       -- instead of css_div or css_span
       -- If XML or other SAAS interchange is specified, 
       -- This value is passed as attibute value pairs within the value's 
       -- wrapper. 
       -- Value is expected to be split by & and = similar to web CGI format.
       xml_format varchar(1000),
);

create index qt_data_types_label_idx on qt_data_types (label);
