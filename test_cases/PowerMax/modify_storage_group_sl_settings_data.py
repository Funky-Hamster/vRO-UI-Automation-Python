modify_storage_group_sl_settings_data = {
    'storage_group_to_modify': POWERMAX_STORAGE_GROUP,
    'enable_compression': POWERMAX_ENABLE_COMPRESSION,
    'storage_resource_pool_${#storagegroup_?_"(current_value_:_"_+_#storagegroup.srp_+_")"_:_""}': POWERMAX_SRP,
    'service_level__${#storagegroup_?_"(current_value_:_"_+_#storagegroup.slo_+_")":_""}': POWERMAX_SLO,
}