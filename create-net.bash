#create two networks
gcloud compute networks create cnet1 --subnet-mode custom
gcoud compute networks create cnet2 --subnet-mode custom

#make firewall policies for networks 
gcloud compute firewall-rules create cnet1-fw --network cnet1 \
    --allow tcp:22,icmp --source-ranges 0.0.0.0/0

gcloud compute firewall-rules create cnet2-fw --network cnet2 \
    --allow tcp:22,icmp --source-ranges 0.0.0.0/0

#create subnets for cnet1, cnet2
gcloud compute networks subnets create subnet-us-east-192 \
    --network cnet1 --region us-east4 --range 192.168.0.0/16
gcloud compute networks subnets create subnet-us-east-10 \
    --network cnet2 --region us-east4 --range 10.1.0.0/24

#making vm for subnets 
gcloud compute instances create cnet1-vm --zone us-east4-a \
    --subnet subnet-us-east-192 --machine-type n1-standard-1 \ 
    --image projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20210927

gcloud compute instances create cnet2-vm1 --zone us-east4-a \
    --subnet subnet-us-east-10 --machine-type n1-standard-1 \
    --image projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20210927

