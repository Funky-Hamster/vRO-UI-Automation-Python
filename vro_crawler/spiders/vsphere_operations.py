import requests
import urllib3
from vmware.vapi.vsphere.client import create_vsphere_client

class VSphereOperations():

    def vsphere_login(self, host, username, password):
        session = requests.session()

        # Disable cert verification for demo purpose. 
        # This is not recommended in a production environment.
        session.verify = False

        # Disable the secure connection warning for demo purpose.
        # This is not recommended in a production environment.
        urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

        # Connect to a vCenter Server using username and password
        vsphere_client = create_vsphere_client(server=host, username=username, password=password, session=session)

        # List all VMs inside the vCenter Server
        vsphere_client.vcenter.VM.list()

        return session