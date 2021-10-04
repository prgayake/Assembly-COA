#include<iostream>
#include<stdlib.h>
#include <unistd.h>

using namespace std;

void stop_n_wait_arq(int *sender,int n,int *receiver){
	int k=0;
	while (1){
		if (k==n){
			break;
		}
		int packet = sender[k];
		cout<<"\nSending "<<k+1<<" Frame ";
		sleep(2);
		int acknowledgement = 1;
		int err = rand()%10;
		if(k==err){
			acknowledgement =0;
			cout<<"\n Acknowledgement Failed ";
			cout<<"\nReSending "<<k+1<<" Frame Again";
			sleep(2);
			acknowledgement = 1;

		}
		if (acknowledgement == 0){
			continue;	
		}
		else{
			receiver[k] = packet;
			cout<<"\n Acknowledgement for "<<k+1<<" Frame ";
			sleep(1);
			k++;
		}
	}
}
int main(){
	int n;
	cin>>n;
  int sender[n];
	for(int i=0;i<n;i++){
		cin>>sender[i];
	}
  int receiver[n];
	stop_n_wait_arq(sender,n,receiver);
	cout<<"\nFinal Received Frame is :";
	for(int i=0;i<n;i++){
		cout<<receiver[i]<<" ";
	}
	return 0;
}