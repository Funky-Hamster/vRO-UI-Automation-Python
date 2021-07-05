failover_srdf_protection_data = {
    'powermax_array': POWERMAX_POWER_MAX_ARRAY,
    'storage_group': POWERMAX_STORAGE_GROUP,
    'the_storage_group_rdf_group': POWERMAX_STORAGE_GROUP_RDF_GROUP,
    'bypass_flag:_bypasses_any_existing_powermax_exclusive_locks_during_an_srdf_operation._warning:_only_use_this_flag_if_you_are_certain_no_other_srdf_operation_is_in_progress_at_the_local_and/or_remote_powermax_arrays.': POWERMAX_BYPASS,
    'restore_flag:_begins_a_full_copy_from_the_target_to_the_source,_synchronizing_the_dynamic_srdf_pairs._the_dynamic_srdf_device_pairs_swap_personality_and_an_incremental_restore_is_initiated.': POWERMAX_RESTORE,
    'immediate_flag:_applies_only_to_srdf/asynchronous_capable_devices._causes_command_to_drop_the_srdf/a_session_immediately.': POWERMAX_IMMEDIATE,
    'remote_flag:_requests_a_remote_data_copy_flag._when_the_concurrent_link_is_ready,_data_is_copied_to_the_concurrent_srdf_mirror._these_operations_require_the_remote_data_copy_option,_or_the_concurrent_link_to_be_suspended.': POWERMAX_REMOTE,
    'establish_flag:_begins_a_device_copy._the_dynamic_srdf_device_pairs_swap_personality_and_an_incremental_establish_is_initiated.': POWERMAX_ESTABLISH,
}