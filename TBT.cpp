#include<iostream>
using namespace std;

class treenode
{
	public:
	int val;
	treenode *left;
	treenode *right;
	int lt;
	int rt;

};


class TBT
{
	public:
		treenode * root;
		TBT()
		{
			root =NULL;
		}

		void create_TBT();
		void insert_node_in_tbt(treenode *temp);
		void inorder_traversal_tbt();
		treenode* inorder_succesor(treenode *t1);



};

void TBT::create_TBT()
{	
	int no;
	int ch=1;
	treenode *temp;
	root =new treenode;
	root ->val =-999;
	root->left=root;
	root->right=root;
	root->lt=1;
	root->rt=1;



			while(ch!=0)
			{
				cout<<"enter value:";
				cin>>no;

					temp =new treenode;
					temp->val=no;
					insert_node_in_tbt(temp);

					cout<<"Do You Want to continue :";
					cin>>ch;
			}
}

void TBT::insert_node_in_tbt(treenode *temp)
{	treenode * t1;
	if(root->lt==1)
	{
		root->left=temp;
		root->lt =0;
		temp->left =root;
		temp->right=root;
		temp->lt=1;
		temp->rt=1;
	}
	else
	{
			t1 = root-> left;

			while(1)
			{
					if(t1->val > temp->val)
					{
						
						if(t1->lt==1)
						{
								temp->left =t1;
								temp->right=t1->right;
								temp->lt=1;
								temp->rt=1;
								t1->left=temp;
								t1->lt=0;
								break;
						
						}
						else
						{
								t1=t1->left;

						}
						
					}
					else
					{
						if(t1->rt==1)
						{
								temp->left =t1->left;
								temp->right=t1;
								temp->lt=1;
								temp->rt=1;
								t1->right=temp;
								t1->lt=0;
								break;
						
						}
						else
						{
								t1=t1->right;

						}
					}
			}
	}
}

void TBT:: inorder_traversal_tbt()
{
	treenode *t1 ;
	t1 =root;

		while(t1->lt==0)
		{
			t1=t1->left;
		}

		cout<<t1->val<<" ";

		while(t1 !=root)
		{
			t1=inorder_succesor(t1);
			cout<<t1->val;
		}
}

treenode * TBT::inorder_succesor(treenode *t1)
{
	if(t1->rt==1)
	{
		t1 =t1->right;
	}
	else
	{
		t1 =t1->right;
		while(t1->lt!=1)
		{
			t1=t1->left;
		}

	}
	return t1;
}


main()
{
	TBT T;
	T.create_TBT();
	T.inorder_traversal_tbt();
}