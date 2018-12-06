# VPC Configuration

#### Create a VPC
```{}
$ aws ec2 create-vpc --cidr-block 10.0.0.0/16
{
    "Vpc": {
        "CidrBlock": "10.0.0.0/16",
        "DhcpOptionsId": "dopt-0e090ea93d72bec9b",
        "State": "pending",
        "VpcId": "vpc-0cf9d64f04c9aeac5",
        "InstanceTenancy": "default",
        "Ipv6CidrBlockAssociationSet": [],
        "CidrBlockAssociationSet": [
            {
                "AssociationId": "vpc-cidr-assoc-01b1ae537c9bf1f59",
                "CidrBlock": "10.0.0.0/16",
                "CidrBlockState": {
                    "State": "associated"
                }
            }
        ],
        "IsDefault": false,
        "Tags": []
    }
}
``` 


#### Know VPC status
```{}
$ aws ec2 describe-vpcs --vpc-ids vpc-0cf9d64f04c9aeac5
```


#### Create a subnet into VPC
```{}
$ aws ec2 create-subnet --availability-zone eu-west-1b --cidr-block 10.0.0.0/24 --vpc-id vpc-0cf9d64f04c9aeac5
{
    "Subnet": {
        "AvailabilityZone": "eu-west-1b",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "10.0.0.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "pending",
        "SubnetId": "subnet-0458d7a0c98cfeb49",
        "VpcId": "vpc-0cf9d64f04c9aeac5",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": []
    }
}
```


#### Create a out gateway (default, VPC is isolated)
```{}
$ aws ec2 create-internet-gateway
{
    "InternetGateway": {
        "Attachments": [],
        "InternetGatewayId": "igw-0410c887b2c9e5518",
        "Tags": []
    }
}
```


#### Add to VPC
```{}
$ aws ec2 attach-internet-gateway --internet-gateway-id igw-0410c887b2c9e5518 --vpc-id vpc-0cf9d64f04c9aeac5
```


#### Show route tables of VPC
```{}
$ aws ec2 describe-route-tables --filters "Name=vpc-id, Values=vpc-0cf9d64f04c9aeac5"
{
    "RouteTables": [
        {
            "Associations": [
                {
                    "Main": true,
                    "RouteTableAssociationId": "rtbassoc-07d7c1aa6f6e88b45",
                    "RouteTableId": "rtb-0d2f521782cfd1135"
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0d2f521782cfd1135",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [],
            "VpcId": "vpc-0cf9d64f04c9aeac5"
        }
    ]
}
```
Default route table is `"Main": true`



#### Add new route for being able to go out from VPC using the new gateway 
```{}
$ aws ec2 create-route --route-table-id rtb-0d2f521782cfd1135 --destination-cidr-block 0.0.0.0/0 --gateway-id igw-0410c887b2c9e5518
{
    "Return": true
}

$ aws ec2 describe-route-tables --filters "Name=vpc-id, Values=vpc-0cf9d64f04c9aeac5"
{
    "RouteTables": [
        {
            "Associations": [
                {
                    "Main": true,
                    "RouteTableAssociationId": "rtbassoc-07d7c1aa6f6e88b45",
                    "RouteTableId": "rtb-0d2f521782cfd1135"
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0d2f521782cfd1135",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "GatewayId": "igw-0410c887b2c9e5518",
                    "Origin": "CreateRoute",
                    "State": "active"
                }
            ],
            "Tags": [],
            "VpcId": "vpc-0cf9d64f04c9aeac5"
        }
    ]
}
```
With that configuration, all subnets will have internet access if they have no route table. 


#### Create route table
```{}
$ aws ec2 create-route-table --vpc-id vpc-0cf9d64f04c9aeac5
{
    "RouteTable": {
        "Associations": [],
        "PropagatingVgws": [],
        "RouteTableId": "rtb-00db6e76d9e67a655",
        "Routes": [
            {
                "DestinationCidrBlock": "10.0.0.0/16",
                "GatewayId": "local",
                "Origin": "CreateRouteTable",
                "State": "active"
            }
        ],
        "Tags": [],
        "VpcId": "vpc-0cf9d64f04c9aeac5"
    }
}

$ aws ec2 describe-route-tables --filters "Name=vpc-id, Values=vpc-0cf9d64f04c9aeac5"
{
    "RouteTables": [
        {
            "Associations": [
                {
                    "Main": true,
                    "RouteTableAssociationId": "rtbassoc-07d7c1aa6f6e88b45",
                    "RouteTableId": "rtb-0d2f521782cfd1135"
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-0d2f521782cfd1135",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                },
                {
                    "DestinationCidrBlock": "0.0.0.0/0",
                    "GatewayId": "igw-0410c887b2c9e5518",
                    "Origin": "CreateRoute",
                    "State": "active"
                }
            ],
            "Tags": [],
            "VpcId": "vpc-0cf9d64f04c9aeac5"
        },
        {
            "Associations": [
                {
                    "Main": false,
                    "RouteTableAssociationId": "rtbassoc-0b30ca93f9f445080",
                    "RouteTableId": "rtb-00db6e76d9e67a655",
                    "SubnetId": "subnet-0458d7a0c98cfeb49"
                }
            ],
            "PropagatingVgws": [],
            "RouteTableId": "rtb-00db6e76d9e67a655",
            "Routes": [
                {
                    "DestinationCidrBlock": "10.0.0.0/16",
                    "GatewayId": "local",
                    "Origin": "CreateRouteTable",
                    "State": "active"
                }
            ],
            "Tags": [],
            "VpcId": "vpc-0cf9d64f04c9aeac5"
        }
    ]
}
```



#### Associate new route table to subnet
```{}
$ aws ec2 associate-route-table --route-table-id rtb-00db6e76d9e67a655 --subnet-id subnet-0458d7a0c98cfeb49
{
    "AssociationId": "rtbassoc-0b30ca93f9f445080"
}
```



#### Create a subnet into VPC
```{}
$ aws ec2 create-subnet --availability-zone eu-west-1b --cidr-block 10.0.0.0/24 --vpc-id vpc-0cf9d64f04c9aeac5
{
    "Subnet": {
        "AvailabilityZone": "eu-west-1b",
        "AvailableIpAddressCount": 251,
        "CidrBlock": "10.0.0.0/24",
        "DefaultForAz": false,
        "MapPublicIpOnLaunch": false,
        "State": "pending",
        "SubnetId": "subnet-030f2245d3fd3c167",
        "VpcId": "vpc-0cf9d64f04c9aeac5",
        "AssignIpv6AddressOnCreation": false,
        "Ipv6CidrBlockAssociationSet": []
    }
}
```