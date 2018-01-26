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
                        ::qdt::data_types

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
                        set partial_idx_list [lsort -unique -integer \
                                                  $partial_idx_list]
                        set partial_list [list ]
                        foreach p $partial_idx_list {
                            lappend partial_list [lindex $labels_list $p]
                        }
                        aa_log "Testing partial dump with t1_arr"
                        ::qdt::data_types $partial_list t1_arr 
                        foreach p2 $partial_list {
                            array set t2_arr [array get qdt_arr "${p2},"]
                        }
                        foreach {n2 v2} [array get t2_arr] {
                            aa_equals "name ${n2} value ${v2}" $t1_arr(${n2}) \
                                $t2_arr(${n2})
                        }
                        aa_log "Testing add a custom local_data_types_lists\
 with t4_arr"
                        set c_list [split {text,text,,input,,1,"a hint qdt test",,,,hf_are_safe_and_visible_characters_q,,,,,,,,} ","]
                        set custom1 [lreplace $c_list 0 0 custom1]
                        ::qdt::data_types $partial_list t4_arr $custom1
                        set nv_list [array get t4_arr "custom1,*"]
                        set nv_data_ct [llength $nv_list]
                        set nv_data_ct [expr { $nv_data_ct / 2 } ]
                        aa_equals "t4_arr custom has same elements" \
                            $nv_data_ct [llength $c_list]
                        aa_log "Testing add custom1 local_data_types_lists\
 with t8_arr"
                        aa_log "custom1 nv_list: $nv_list"
                        aa_log "c_list: $c_list"
                        set custom2 [lreplace $c_list 0 0 custom2]
                        ::qdt::data_types $partial_list t8_arr \
                            [list $custom1 $custom2]
                        set nv_list [array get t8_arr "custom1,*"]
                        set nv_data_ct [llength $nv_list]
                        set nv_data_ct [expr { $nv_data_ct / 2 } ]
                        aa_equals "t8_arr custom1 has same elements" \
                            $nv_data_ct [llength $c_list]
                        set nv_list [array get t8_arr "custom2,*"]
                        set nv_data_ct [llength $nv_list]
                        set nv_data_ct [expr { $nv_data_ct / 2 } ]
                        aa_equals "t8_arr custom2 has same elements" \
                            $nv_data_ct [llength $c_list]

                        ns_log Notice "tcl/test/qdt-procs.tcl.429 test end"
                    } \
        -teardown_code {

        }
    #aa_true "Test for .." $passed_p
    #aa_equals "Test for .." $test_value $expected_value


}
