add_rdm_volume_to_vm_data = {
    'virtual_machine': POWERMAX_VM,
    'lun_identifier': POWERMAX_LUN_IDENTIFIER,
    'compatibility_mode
(physicalmode:_array_snapshot,_virtualmode:_vmware_snapshot)': POWERMAX_COMPATIBILITY_MODE,
    'disk_mode
(dependent:_included_in_snapshot,_persistent:_normal,_nonpersistent:_writes_discard_on_vm_power_off)': POWERMAX_DISK_MODE,
    'name_of_hba_on_vm': POWERMAX_HBA,
    'datastore_to_contain_the_rdm_mapping_file': POWERMAX_DATASTORE,
    'device_scsi_id': POWERMAX_LUN_SCSI_ID,
}