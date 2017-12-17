ad_library {

    API for the q-data-types package
    @creation-date 16 Dec 2017
}

ad_proc -public qdt_data_types {
    {label_list ""}
    {array_name "qdt_arr"}
} {
    Returns data type records in an array q-data-type
    using reference fomat (label,qdt_data_types.fieldname).
    For example: array_name(text,css_span).

    If label_list is empty string, returns all entries in qdt_data_types.
    If array_name not supplied, uses qdt_arr
} {
    upvar $array_name d_arr
    if { $label_list ne "" } {

        # fieldnames
        set f_ol [list label
                  max_length
                  form_tag_type
                  empty_allowed_p
                  input_hint
                  text_format_proc
                  tcl_format_str
                  tcl_clock_format_str
                  valida_roc
                  filter_proc
                  default_proc
                  css_span
                  css_div
                  html_style
                  abbrev_proc
                  css_abbrev 
                  xml_format]

        if { [llength $label_list ] eq 1 } {
            
            set qdt_ul [db_list_of_lists qdt_data_types_r {
                select label,
                max_length,
                form_tag_type,
                empty_allowed_p,
                input_hint,
                text_format_proc,
                tcl_format_str,
                tcl_clock_format_str,
                valida_roc,
                filter_proc,
                default_proc,
                css_span,
                css_div,
                html_style,
                abbrev_proc,
                css_abbrev,
                xml_format
                from qdt_data_types where label=:label_list } ]

        } else {

            set labels [template::util::tcl_to_sql_list $label_list]
            set qdt_ul [db_list_of_lists qdt_data_types_r2 {
                select label,
                max_length,
                form_tag_type,
                empty_allowed_p,
                input_hint,
                text_format_proc,
                tcl_format_str,
                tcl_clock_format_str,
                valida_roc,
                filter_proc,
                default_proc,
                css_span,
                css_div,
                html_style,
                abbrev_proc,
                css_abbrev,
                xml_format
                from qdt_data_types where label in (:labels) } ]
        }

        foreach row qdt_ul {
            set i 0

##code
            set f [lindex $row 0]
            foreach f $f_ol {
                incr i
                
                d_arr(${
        }

    } else {

            set qdt_ul [db_list_of_lists qdt_data_types_rall {
                select label,
                max_length,
                form_tag_type,
                empty_allowed_p,
                input_hint,
                text_format_proc,
                tcl_format_str,
                tcl_clock_format_str,
                valida_roc,
                filter_proc,
                default_proc,
                css_span,
                css_div,
                html_style,
                abbrev_proc,
                css_abbrev,
                xml_format
                from qdt_data_types } ]

    }
}