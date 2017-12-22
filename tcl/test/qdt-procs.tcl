ad_library {
    Automated tests for q-data-types
    @creation-date 20171221
}

aa_register_case -cats {api smoke} qdt_check {
    Test api 
} {
    aa_run_with_teardown \
        -test_code {
            # -rollback \
                        ns_log Notice "tcl/test/qdt-procs.tcl.12: test begin"
                        set instance_id [ad_conn package_id]            
                        # create a scenario to test this api:

                        aa_log "Testing full dump with default qdt_arr"
                        qdt_data_types

                        # build list of types
                        set labels_list [list ]
                        foreach {n v} [array get qdt_arr "*,label"] {
                            lappend labels_list $v
                        }

                        set target_len [llength $labels_list]
                        set p_len [expr { $target_len / 2 } ]

                        set partial_idx_list [list]
                        for {set i 0} {$i < $p_len } { incr i} {
                            lappend partial_idx_list [randomRange $target_len]
                        }
                        set partial_idx_list [lsort -unqiue -integer \
                                                  $partial_idx_list]
                        set partial_list [list ]
                        foreach p $partial_idx_list {
                            lappend partial_list [lindex $labels_list $p]
                        }
                        aa_log "Testing partial dump with t1_arr"
                        qdt_data_types $partial_list t1_arr 
                        foreach p2 $partial_list {
                            array set t2_arr [array get qdt_arr "${p2},"]
                        }
                        foreach {n2 v2} [array get t2_arr] {
                            aa_equals "name ${n2} value ${v2}" $t1_arr(${n2}) \
                                $t2_arr(${n2})
                        }
                        aa_log "Testing add a custom local_data_types_lists\
 with t4_arr"
                        ##code
                        ns_log Notice "tcl/test/qdt-procs.tcl.429 test end"
                    } \
        -teardown_code {

        }
    #aa_true "Test for .." $passed_p
    #aa_equals "Test for .." $test_value $expected_value


}
