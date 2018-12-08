# How to execute
`$ ./01-producer.sh <sqs-profile> <messages-to-send> <queue-name>`

`$ ./02-load-balancer.sh <sqs-profile> <queue-name>`
	
`$ ./03-consumer.sh <sqs-profile> <queue-name>`