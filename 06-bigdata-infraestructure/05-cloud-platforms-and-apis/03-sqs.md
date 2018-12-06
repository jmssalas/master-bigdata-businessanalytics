# SQS (Simple Queue Service)

#### Create a FIFO Queue
```{}
$ aws --profile sqs sqs create-queue --queue-name masterfifoqueue.fifo --attributes {\"FifoQueue\":\"true\"}
{
    "QueueUrl": "https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo"
}
``` 


#### Add a new message into the queue
```{}
$ aws --profile sqs sqs send-message --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo --message-body "First test message" --message-group-id 1 --message-deduplication-id 1
{
    "MD5OfMessageBody": "d0dd600bce1f5d7a2d0e2f8e9f161655",
    "MessageId": "3a87adea-7d18-45da-b24d-d2a20209abe9",
    "SequenceNumber": "18842042715335407872"
}
``` 


#### Get the amount of queue's messages
```{}
$ aws --profile sqs sqs get-queue-attributes --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo --attribute-names "ApproximateNumberOfMessages" --query 'Attributes' --output text
1
``` 


#### Recive a message from queue
```{}
$ aws --profile sqs sqs receive-message --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo --attribute-names ApproximateReceiveCount --wait-time-seconds 20
{
    "Messages": [
        {
            "MessageId": "3a87adea-7d18-45da-b24d-d2a20209abe9",
            "ReceiptHandle": "AQEB0Wrd70/xbepyGTai+nB9YGNcXUYp6YPt1eoJn/kfoNSFa8tYOYBTC9P/UdDps3W6tUwvKIDEGkt/9UqifNQkybCZjUYrWws1vPT9GTVLjqV6a0BAcM6Hlr4hhD/RwT/qnn81lT+xB5e14yZQUh44ltVLduXO+EIdZmIXrkNH4pGJPavDQC8oARxonHGwIOapi7H+cvnmQjCpsKFmmE7brvNwLylVEcksat2RnBsrtY5V9qmjg48AHqVLlmnL+p2Pf6BPd5BNlU0XzFuY/pfdCjJmq8ZVCy/HygdrTmcESXc=",
            "MD5OfBody": "d0dd600bce1f5d7a2d0e2f8e9f161655",
            "Body": "First test message",
            "Attributes": {
                "ApproximateReceiveCount": "1"
            }
        }
    ]
}
``` 


#### Delete a message
```{}
$ aws --profile sqs sqs delete-message --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo --receipt-handle AQEB0Wrd70/xbepyGTai+nB9YGNcXUYp6YPt1eoJn/kfoNSFa8tYOYBTC9P/UdDps3W6tUwvKIDEGkt/9UqifNQkybCZjUYrWws1vPT9GTVLjqV6a0BAcM6Hlr4hhD/RwT/qnn81lT+xB5e14yZQUh44ltVLduXO+EIdZmIXrkNH4pGJPavDQC8oARxonHGwIOapi7H+cvnmQjCpsKFmmE7brvNwLylVEcksat2RnBsrtY5V9qmjg48AHqVLlmnL+p2Pf6BPd5BNlU0XzFuY/pfdCjJmq8ZVCy/HygdrTmcESXc=
``` 


#### Purge the queue
```{}
$ aws --profile sqs sqs purge-queue --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo 
``` 



#### Delete the queue
```{}
$ aws --profile sqs sqs delete-queue --queue-url https://eu-west-1.queue.amazonaws.com/614751959247/masterfifoqueue.fifo 
``` 