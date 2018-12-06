# Instances, EC2 Configuration and Basic Services

#### Create a SG (Security Group) (associated to VPC)
```{}
$ aws ec2 create-security-group --description "SSH Access" --group-name SSHAccess --vpc-id vpc-0cf9d64f04c9aeac5
{
    "GroupId": "sg-015c48f6955832223"
}

``` 


#### Configure SG Ports
```{}
$ aws ec2 authorize-security-group-ingress --group-id sg-015c48f6955832223 --protocol tcp --port 22 --cidr 0.0.0.0/0
```


#### Check SG Configuration
```{}
$ aws ec2 describe-security-groups --group-id sg-015c48f6955832223
{
    "SecurityGroups": [
        {
            "Description": "SSH Access",
            "GroupName": "SSHAccess",
            "IpPermissions": [
                {
                    "FromPort": 22,
                    "IpProtocol": "tcp",
                    "IpRanges": [
                        {
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": [],
                    "ToPort": 22,
                    "UserIdGroupPairs": []
                }
            ],
            "OwnerId": "614751959247",
            "GroupId": "sg-015c48f6955832223",
            "IpPermissionsEgress": [
                {
                    "IpProtocol": "-1",
                    "IpRanges": [
                        {
                            "CidrIp": "0.0.0.0/0"
                        }
                    ],
                    "Ipv6Ranges": [],
                    "PrefixListIds": [],
                    "UserIdGroupPairs": []
                }
            ],
            "VpcId": "vpc-0cf9d64f04c9aeac5"
        }
    ]
}
```


#### Create a Key pair to access to the instance
```{}
$ aws ec2 create-key-pair --key-name "MasterKey" --query '{KeyMaterial:KeyMaterial}' --output text > MasterKey.pem
```


#### Modify the user access permissions
```{}
$ chmod 600 MasterKey.pem 
$ ls -lisa MasterKey.pem 
265586 4 -rw------- 1 vagrant vagrant 1671 Dec  6 18:32 MasterKey.pem
```


#### List the keys created
```{}
$ aws ec2 describe-key-pairs
{
    "KeyPairs": [
        {
            "KeyFingerprint": "d0:5b:88:e8:03:cf:41:5c:41:9b:23:8f:6b:df:cb:fd:f2:81:78:20",
            "KeyName": "MasterKey"
        }
    ]
}

```


#### Before creating the instance, we have to know the AMI's ID
```{}
$ aws ec2 describe-images --filters "Name=virtualization-type,Values=hvm" "Name=is-public,Values=true" --query 'Images[*].{ID:ImageId, Description:Description, Name:Name, CreationDate:CreationDate}.sort_by(@, &CreationDate)' --output text | grep -v testing | grep -v None | grep "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server"

[...]

2018-10-24T14:16:35.000Z	[Copied ami-58d7e821 from eu-west-1] ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20180522	ami-05e2fa3e100f8d881	ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20180522

2018-11-07T16:55:04.000Z	Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-11-06	ami-00cc9e3eecbef4b46	ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20181106

2018-11-21T01:46:47.000Z	Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-11-14	ami-09f0b8b3e41191524	ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20181114
```


#### Get `ami-09f0b8b3e41191524` AMI features
```{}
$ aws ec2 describe-images --image-id ami-09f0b8b3e41191524
{
    "Images": [
        {
            "Architecture": "x86_64",
            "CreationDate": "2018-11-21T01:46:47.000Z",
            "ImageId": "ami-09f0b8b3e41191524",
            "ImageLocation": "099720109477/ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20181114",
            "ImageType": "machine",
            "Public": true,
            "OwnerId": "099720109477",
            "State": "available",
            "BlockDeviceMappings": [
                {
                    "DeviceName": "/dev/sda1",
                    "Ebs": {
                        "DeleteOnTermination": true,
                        "SnapshotId": "snap-0b737a383cbfba2e8",
                        "VolumeSize": 8,
                        "VolumeType": "gp2",
                        "Encrypted": false
                    }
                },
                {
                    "DeviceName": "/dev/sdb",
                    "VirtualName": "ephemeral0"
                },
                {
                    "DeviceName": "/dev/sdc",
                    "VirtualName": "ephemeral1"
                }
            ],
            "Description": "Canonical, Ubuntu, 16.04 LTS, amd64 xenial image build on 2018-11-14",
            "EnaSupport": true,
            "Hypervisor": "xen",
            "Name": "ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-20181114",
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SriovNetSupport": "simple",
            "VirtualizationType": "hvm"
        }
    ]
}

```


#### Create an instance using the previous AMI
```{}
$ aws ec2 run-instances --image-id ami-09f0b8b3e41191524 --count 1 --instance-type t2.micro --key-name "MasterKey" --security-group-ids sg-015c48f6955832223 --subnet-id subnet-030f2245d3fd3c167 --instance-initiated-shutdown-behavior terminate --associate-public-ip-address --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=TestInstance}]'
{
    "Groups": [],
    "Instances": [
        {
            "AmiLaunchIndex": 0,
            "ImageId": "ami-09f0b8b3e41191524",
            "InstanceId": "i-09da801426323aa5b",
            "InstanceType": "t2.micro",
            "KeyName": "MasterKey",
            "LaunchTime": "2018-12-06T19:46:24.000Z",
            "Monitoring": {
                "State": "disabled"
            },
            "Placement": {
                "AvailabilityZone": "eu-west-1b",
                "GroupName": "",
                "Tenancy": "default"
            },
            "PrivateDnsName": "ip-10-0-0-242.eu-west-1.compute.internal",
            "PrivateIpAddress": "10.0.0.242",
            "ProductCodes": [],
            "PublicDnsName": "",
            "State": {
                "Code": 0,
                "Name": "pending"
            },
            "StateTransitionReason": "",
            "SubnetId": "subnet-030f2245d3fd3c167",
            "VpcId": "vpc-0cf9d64f04c9aeac5",
            "Architecture": "x86_64",
            "BlockDeviceMappings": [],
            "ClientToken": "",
            "EbsOptimized": false,
            "Hypervisor": "xen",
            "NetworkInterfaces": [
                {
                    "Attachment": {
                        "AttachTime": "2018-12-06T19:46:24.000Z",
                        "AttachmentId": "eni-attach-02377dc567f34beb6",
                        "DeleteOnTermination": true,
                        "DeviceIndex": 0,
                        "Status": "attaching"
                    },
                    "Description": "",
                    "Groups": [
                        {
                            "GroupName": "SSHAccess",
                            "GroupId": "sg-015c48f6955832223"
                        }
                    ],
                    "Ipv6Addresses": [],
                    "MacAddress": "02:00:ac:ed:b9:c8",
                    "NetworkInterfaceId": "eni-0a4ba15870058f48b",
                    "OwnerId": "614751959247",
                    "PrivateIpAddress": "10.0.0.242",
                    "PrivateIpAddresses": [
                        {
                            "Primary": true,
                            "PrivateIpAddress": "10.0.0.242"
                        }
                    ],
                    "SourceDestCheck": true,
                    "Status": "in-use",
                    "SubnetId": "subnet-030f2245d3fd3c167",
                    "VpcId": "vpc-0cf9d64f04c9aeac5"
                }
            ],
            "RootDeviceName": "/dev/sda1",
            "RootDeviceType": "ebs",
            "SecurityGroups": [
                {
                    "GroupName": "SSHAccess",
                    "GroupId": "sg-015c48f6955832223"
                }
            ],
            "SourceDestCheck": true,
            "StateReason": {
                "Code": "pending",
                "Message": "pending"
            },
            "Tags": [
                {
                    "Key": "Name",
                    "Value": "TestInstance"
                }
            ],
            "VirtualizationType": "hvm",
            "CpuOptions": {
                "CoreCount": 1,
                "ThreadsPerCore": 1
            }
        }
    ],
    "OwnerId": "614751959247",
    "ReservationId": "r-02d785a0d19f7d930"
}
```


#### Get the instance's public IP
```{}
$ aws ec2 describe-instances --instance-id i-09da801426323aa5b --query 'Reservations[*].Instances[*].{IPPublica:PublicIpAddress}' --output text
34.248.127.246
```



#### Connect to instance by SSH
```{}
$ ssh ubuntu@34.248.127.246 -i MasterKey.pem
The authenticity of host '34.248.127.246 (34.248.127.246)' can't be established.
ECDSA key fingerprint is SHA256:ix0spJxTPIKjDD2gnHPO6tkPKodVks+z8mwKMSB4pjg.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '34.248.127.246' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 16.04.5 LTS (GNU/Linux 4.4.0-1072-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-10-0-0-242:~$ 
```



#### Stop the instance
```{}
$ aws ec2 stop-instances --instance-id i-09da801426323aa5b
{
    "StoppingInstances": [
        {
            "CurrentState": {
                "Code": 64,
                "Name": "stopping"
            },
            "InstanceId": "i-09da801426323aa5b",
            "PreviousState": {
                "Code": 16,
                "Name": "running"
            }
        }
    ]
}
```


#### Terminate the instance (with that, the instance will be destroyed)
```{}
$ aws ec2 terminate-instances --instance-id i-09da801426323aa5b
{
    "TerminatingInstances": [
        {
            "CurrentState": {
                "Code": 48,
                "Name": "terminated"
            },
            "InstanceId": "i-09da801426323aa5b",
            "PreviousState": {
                "Code": 80,
                "Name": "stopped"
            }
        }
    ]
}
```