# label: PowerScale cluster, id: cluster, type: dropdown
POWERSCALE_CLUSTER = ''
# label: Connection name, id: connectionName, type: text-field
POWERSCALE_CONNECTION_NAME = ''
# label: PowerScale port number, id: port, type: text-field
POWERSCALE_PORT = ''
# label: PowerScale username, id: username, type: text-field
POWERSCALE_USERNAME = ''
# label: PowerScale password, id: password, type: password-field
POWERSCALE_PASSWORD = ''
# label:  If you select Yes, the storage management server instance certificate is accepted silently and the certificate is added to the truststore, id: ignoreCertificateWarning, type: checkbox
POWERSCALE_IGNORE_CERTIFICATE_WARNING = ''
# label: PowerScale host, id: host, type: text-field
POWERSCALE_HOST = ''
# label: Access zone, id: zone, type: dropdown
POWERSCALE_ZONE = ''
# label: NFS alias, id: nfsAlias, type: dropdown
POWERSCALE_NFS_ALIAS = ''
# label: JSON string of NFS export summary information, id: summaries, type: dropdown
POWERSCALE_SUMMARIES = ''
# label: NFS export paths information, id: pathsInfo, type: dropdown
POWERSCALE_PATHS_INFO = ''
# label: NFS export id, id: id, type: dropdown
POWERSCALE_ID = ''
# label: Quota path, id: path, type: dropdown
POWERSCALE_PATH = ''
# label: Cluster, id: clusterName, type: dropdown
POWERSCALE_CLUSTER_NAME = ''
# label: SMB share name, id: smbShareName, type: dropdown
POWERSCALE_SMB_SHARE_NAME = ''
# label: NFS alias name (will be represented in the filesystem as "/aliasname"), id: name, type: text-field
POWERSCALE_NAME = ''
# label: Access zone base path, id: zoneBase, type: text-field
POWERSCALE_ZONE_BASE = ''
# label: Use NFS alias, id: usingAlias, type: checkbox
POWERSCALE_USING_ALIAS = ''
# label: Description of the export, id: description, type: textarea
POWERSCALE_DESCRIPTION = ''
# label: Clients to be allowed access to the export, id: clients, type: array
POWERSCALE_CLIENTS = ''
# label: Clients to be allowed read write access to the export, id: readWriteClients, type: array
POWERSCALE_READ_WRITE_CLIENTS = ''
# label: Clients to be allowed read only access to the export, id: readOnlyClients, type: array
POWERSCALE_READ_ONLY_CLIENTS = ''
# label: Clients that have root access to the export, id: rootClients, type: array
POWERSCALE_ROOT_CLIENTS = ''
# label: Restrict export access to read only, id: isReadOnly, type: checkbox
POWERSCALE_IS_READ_ONLY = ''
# label: Enable mount access to subdirectories, id: mountSubDirs, type: checkbox
POWERSCALE_MOUNT_SUB_DIRS = ''
# label: Hidden parameter for all user names in zone, id: users, type: array
POWERSCALE_USERS = ''
# label: Hidden parameter for all user group names in zone, id: groups, type: array
POWERSCALE_GROUPS = ''
# label: Use default value for root user mapping, id: useDefaultRootMapping, type: checkbox
POWERSCALE_USE_DEFAULT_ROOT_MAPPING = ''
# label: Enable root users mapping , id: mapRootUsers, type: checkbox
POWERSCALE_MAP_ROOT_USERS = ''
# label: Root mapping user, id: rootMappingUser, type: dropdown
POWERSCALE_ROOT_MAPPING_USER = ''
# label: Root mapping primary group, id: rootMappingPrimaryGroup, type: dropdown
POWERSCALE_ROOT_MAPPING_PRIMARY_GROUP = ''
# label: Root mapping secondary groups, id: rootMappingSecondaryGroups, type: multi-select
POWERSCALE_ROOT_MAPPING_SECONDARY_GROUPS = ''
# label: Use default value for non-root user mapping, id: useDefaultNonRootMapping, type: checkbox
POWERSCALE_USE_DEFAULT_NON_ROOT_MAPPING = ''
# label: Enable non-root users mapping, id: mapNonRootUsers, type: checkbox
POWERSCALE_MAP_NON_ROOT_USERS = ''
# label: Non-root mapping user, id: nonRootMappingUser, type: dropdown
POWERSCALE_NON_ROOT_MAPPING_USER = ''
# label: Non-root mapping primary group, id: nonRootMappingPrimaryGroup, type: dropdown
POWERSCALE_NON_ROOT_MAPPING_PRIMARY_GROUP = ''
# label: Non-root mapping secondary groups, id: nonRootMappingSecondaryGroups, type: multi-select
POWERSCALE_NON_ROOT_MAPPING_SECONDARY_GROUPS = ''
# label: Use default value for failed user mapping, id: useDefaultFailedMapping, type: checkbox
POWERSCALE_USE_DEFAULT_FAILED_MAPPING = ''
# label: Enable failed users mapping , id: mapFailedUsers, type: checkbox
POWERSCALE_MAP_FAILED_USERS = ''
# label: Failed mapping user, id: failedMappingUser, type: dropdown
POWERSCALE_FAILED_MAPPING_USER = ''
# label: Failed mapping primary group, id: failedMappingPrimaryGroup, type: dropdown
POWERSCALE_FAILED_MAPPING_PRIMARY_GROUP = ''
# label: Failed mapping secondary groups, id: failedMappingSecondaryGroups, type: multi-select
POWERSCALE_FAILED_MAPPING_SECONDARY_GROUPS = ''
# label: Use default security types, id: useDefaultSecurityTypes, type: checkbox
POWERSCALE_USE_DEFAULT_SECURITY_TYPES = ''
# label: Security types, id: securityTypes, type: multi-select
POWERSCALE_SECURITY_TYPES = ''
# label: Mount export to Linux VMs, id: mount, type: checkbox
POWERSCALE_MOUNT = ''
# label:  Linux Hosts that will mount the created NFS export , id: sshHostList, type: datagrid
POWERSCALE_SSH_HOST_LIST = ''
# label: Do you want to use password authentication? If unchecked, public key authentication will be used., id: passwordAuthentication, type: checkbox
POWERSCALE_PASSWORD_AUTHENTICATION = ''
# label:  Passwords of the registered SSH hosts , id: passwords, type: datagrid
POWERSCALE_PASSWORDS = ''
# label: Paths to the private keys (To use default key path for all hosts, keep empty), id: keyPaths, type: array
POWERSCALE_KEY_PATHS = ''
# label:  Private key pass-phrases , id: passPhrases, type: datagrid
POWERSCALE_PASS_PHRASES = ''
# label: NFS server IP to mount the export. (Note the IP might vary depending on the access zone the export belongs to.), id: nfsServerIp, type: text-field
POWERSCALE_NFS_SERVER_IP = ''
# label: Mount point, id: mountPoint, type: text-field
POWERSCALE_MOUNT_POINT = ''
# label: Unmount already mounted path, id: unmount, type: checkbox
POWERSCALE_UNMOUNT = ''
# label: NFS protocol version for mounting, id: nfsVersion, type: dropdown
POWERSCALE_NFS_VERSION = ''
# label: WARNING: You need to manually unmount the export on your clients before running the workflow. Have you unmounted the export on your clients?
# id: confirm, type: checkbox
POWERSCALE_CONFIRM = ''
# label: JSON string of NFS export instance properties, id: nfsExportPropertiesString, type: text-field
POWERSCALE_NFS_EXPORT_PROPERTIES_STRING = ''
# label: Modify clients access lists for mounting hosts?, id: modifyClientsAccess, type: checkbox
POWERSCALE_MODIFY_CLIENTS_ACCESS = ''
# label: Export has multiple paths or not, id: multiplePaths, type: checkbox
POWERSCALE_MULTIPLE_PATHS = ''
# label: Export paths to mount, id: paths, type: multi-select
POWERSCALE_PATHS = ''
# label: Mount points, id: mountPoints, type: array
POWERSCALE_MOUNT_POINTS = ''
# label: Check if smart quota license is applied, id: isQuotaLicenseApplied, type: checkbox
POWERSCALE_IS_QUOTA_LICENSE_APPLIED = ''
# label: Quota type, id: quotaType, type: dropdown
POWERSCALE_QUOTA_TYPE = ''
# label: Include snapshots in storage quota, id: includeSnapshots, type: checkbox
POWERSCALE_INCLUDE_SNAPSHOTS = ''
# label: Enforce the limits on this quota based on, id: enforceLimitsBasedOn, type: dropdown
POWERSCALE_ENFORCE_LIMITS_BASED_ON = ''
# label: Enforce limits, id: enforceLimits, type: dropdown
POWERSCALE_ENFORCE_LIMITS = ''
# label: Set an advisory storage limit, id: advisoryStorageLimit, type: checkbox
POWERSCALE_ADVISORY_STORAGE_LIMIT = ''
# label: Advisory limit value, id: advisoryLimitValue, type: decimal-field
POWERSCALE_ADVISORY_LIMIT_VALUE = ''
# label: Advisory limit unit, id: advisoryLimitUnit, type: dropdown
POWERSCALE_ADVISORY_LIMIT_UNIT = ''
# label: Set a soft storage limit, id: softStorageLimit, type: checkbox
POWERSCALE_SOFT_STORAGE_LIMIT = ''
# label: Soft limit value, id: softLimitValue, type: decimal-field
POWERSCALE_SOFT_LIMIT_VALUE = ''
# label: Soft limit unit, id: softLimitUnit, type: dropdown
POWERSCALE_SOFT_LIMIT_UNIT = ''
# label: Soft grace period, id: softGracePeriod, type: decimal-field
POWERSCALE_SOFT_GRACE_PERIOD = ''
# label: Soft grace period unit, id: softGraceUnit, type: dropdown
POWERSCALE_SOFT_GRACE_UNIT = ''
# label: Set a hard storage limit, id: hardStorageLimit, type: checkbox
POWERSCALE_HARD_STORAGE_LIMIT = ''
# label: Hard limit value, id: hardLimitValue, type: decimal-field
POWERSCALE_HARD_LIMIT_VALUE = ''
# label: Hard limit unit, id: hardLimitUnit, type: dropdown
POWERSCALE_HARD_LIMIT_UNIT = ''
# label: Show available space as, id: showAvailableSpaceAs, type: dropdown
POWERSCALE_SHOW_AVAILABLE_SPACE_AS = ''
# label: Quota properties json string, id: propertiesString, type: text-field
POWERSCALE_PROPERTIES_STRING = ''
# label: Advisory limit value, id: advisoryLimit, type: text-field
POWERSCALE_ADVISORY_LIMIT = ''
# label: Soft limit value, id: softLimit, type: text-field
POWERSCALE_SOFT_LIMIT = ''
# label: Soft grace period, id: softGrace, type: text-field
POWERSCALE_SOFT_GRACE = ''
# label: Hard limit value, id: hardLimit, type: text-field
POWERSCALE_HARD_LIMIT = ''
# label: Create SMB share directory if it does not exist, id: createIfNotExist, type: checkbox
POWERSCALE_CREATE_IF_NOT_EXIST = ''
# label: Directory ACLs, id: dirACL, type: dropdown
POWERSCALE_DIR_ACL = ''
# label: Allow variable expansion, id: allowVarExp, type: checkbox
POWERSCALE_ALLOW_VAR_EXP = ''
# label: Create home directories for users when they first access the share path with expansion variables., id: autoCreateDir, type: checkbox
POWERSCALE_AUTO_CREATE_DIR = ''
# label: Continuous Availability, id: enableContinuousAvailability, type: checkbox
POWERSCALE_ENABLE_CONTINUOUS_AVAILABILITY = ''
# label: Read-only users, id: roUsers, type: multi-select
POWERSCALE_RO_USERS = ''
# label: Read-write users, id: rwUsers, type: multi-select
POWERSCALE_RW_USERS = ''
# label: Full control users, id: fcUsers, type: multi-select
POWERSCALE_FC_USERS = ''
# label: Root users, id: rtUsers, type: multi-select
POWERSCALE_RT_USERS = ''
# label: Read-only groups, id: roGroups, type: multi-select
POWERSCALE_RO_GROUPS = ''
# label: Read-write groups, id: rwGroups, type: multi-select
POWERSCALE_RW_GROUPS = ''
# label: Full control groups, id: fcGroups, type: multi-select
POWERSCALE_FC_GROUPS = ''
# label: Root groups, id: rtGroups, type: multi-select
POWERSCALE_RT_GROUPS = ''
# label: Read-only well-known SIDs, id: roWellknowns, type: multi-select
POWERSCALE_RO_WELLKNOWNS = ''
# label: Read-write well-known SIDs, id: rwWellknowns, type: multi-select
POWERSCALE_RW_WELLKNOWNS = ''
# label: Full control well-known SIDs, id: fcWellknowns, type: multi-select
POWERSCALE_FC_WELLKNOWNS = ''
# label: Root well-known SIDs, id: rtWellknowns, type: multi-select
POWERSCALE_RT_WELLKNOWNS = ''
# label: Enable file filters, id: enableFileFilters, type: checkbox
POWERSCALE_ENABLE_FILE_FILTERS = ''
# label: File filter type, id: fileFilterType, type: dropdown
POWERSCALE_FILE_FILTER_TYPE = ''
# label: File Filter Extensions, id: fileFilterExtensions, type: array
POWERSCALE_FILE_FILTER_EXTENSIONS = ''
# label: Client IP, id: computer, type: dropdown
POWERSCALE_COMPUTER = ''
# label: User, id: user, type: dropdown
POWERSCALE_USER = ''
# label: SMB share object, id: smbShareObj, type: value-picker
POWERSCALE_SMB_SHARE_OBJ = ''
# label: Name, id: newSmbShareName, type: text-field
POWERSCALE_NEW_SMB_SHARE_NAME = ''
