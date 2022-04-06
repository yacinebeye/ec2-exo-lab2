import boto3 # boto 3 installed in the terminal before import 


#Setting out the variable called Html page 
html_page = "<html><body><h1>The List of instances from the private Subnet<h1>"


# GET THE SUBNET INFO
def getPrivateSubnetId():

    ec2_client = boto3.client('ec2')
    subnets_info = ec2_client.describe_subnets()

    for subnet in subnets_info['Subnets']:
        if (subnet["Tags"][0]["Value"]) == "talent-academy-private-a":
            #print(subnet)
            private_subnet = subnet["SubnetId"]
            return private_subnet 

private_subnet = getPrivateSubnetId()            


ec2 = boto3.resource('ec2')

for instance in ec2.instances.all():

    #if instance.public_ip_address == None and instance.subnet_id  == private_subnet: This version has been simplified to the version below 
    if instance.subnet_id  == private_subnet: 
        #print(#)CHANGING THE PRINT OPTION TO PRINT THE HTML PAGE 
        html_page += "<p>Id: {0}<br>Platform: {1}<br>Type: {2}<br>Public IPv4: {3}<br>AMI: {4}<br>State: {5}<br>Subnet: {6}<br><br><br></p>".format(
                        instance.id, instance.platform, instance.instance_type, instance.public_ip_address, instance.image.id, instance.state, instance.subnet_id
                    )
html_page += "<body><html>"        

print(html_page)

# How to open an html file 
html_file = open("index.html", "w")
html_file.write(html_page)
html_file.close()
