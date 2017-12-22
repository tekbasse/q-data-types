ad_library {

    API for the q-data-types package
    @creation-date 16 Dec 2017
}

ad_proc -public qdt_data_types {
    {label_list ""}
    {array_name "qdt_arr"}
    {local_data_types_lists ""}
} {
    Returns data type records in an array q-data-type
    using reference fomat (label,qdt_data_types.fieldname).
    For example: 
    array_name(text,css_span) for label "text" attribute "css_span".

    If label_list is empty string, returns all entries in qdt_data_types.
    If array_name not supplied, array_name is qdt_arr

    If qdt_data_types does not have a type for local use, new types
    can be added via local_data_types_lists.
    Use the same ordered list of values as supplied by query. 
    See code for details.

} {
    upvar $array_name d_arr
    set qdt_ul [list ]

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
    if { $local_data_types_lists ne "" } {
        if { [lindex $local_data_types_lists 0] ne 1 } {
            set qdt_ul [concat $qdt_ul $local_data_types_lists]
        } else {
            lappend qdt_ul $local_data_types_lists
    }
    foreach row $qdt_ul {
        set i 0
        set f [lindex $row 0]
        foreach fn $f_ol {
            set d_arr(${f},${fn}) [lindex $row $i]
            incr i
        }
    }
    return 1
}

