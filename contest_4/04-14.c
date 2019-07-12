#include <malloc.h> 
#include <stdio.h> 
#include <stdlib.h>

typedef struct Node 
{ 
	int data; 
	struct Node *next; 
	struct Node *prev; 
} Node; 

void swap (int* a, int* b) 
{ 
    int t = *a;	 
    *a = *b;	 
    *b = t; 
} 

Node *lastNode(Node *root) 
{ 
	while (root && root->next) 
		root = root->next; 
	return root; 
} 

Node* partition(Node *l, Node *h) 
{ 
	// set pivot as h element 
	int x = h->data; 

	// similar to i = l-1 for array implementation 
	Node *i = l->prev; 

	// Similar to "for (int j = l; j <= h- 1; j++)" 
	for (Node *j = l; j != h; j = j->next) 
	{ 
		if (j->data <= x) 
		{ 
			// Similar to i++ for array 
			i = (i == NULL)? l : i->next; 

			swap(&(i->data), &(j->data)); 
		} 
	} 
	i = (i == NULL)? l : i->next; // Similar to i++ 
	swap(&(i->data), &(h->data)); 
	return i; 
} 

void quickSort(Node* l, Node *h) 
{ 
	if (h != NULL && l != h && l != h->next) 
	{ 
		Node *p = partition(l, h); 
		quickSort(l, p->prev); 
		quickSort(p->next, h); 
	} 
}

void printList(Node *head) 
{ 
    Node *tmp = head;
	while (tmp) 
	{ 
		printf("%d ", tmp->data); 
		tmp = tmp->next; 
	}  
    printf("\n");
} 

int main() 
{
    FILE *fin;
    fin = fopen("/home/main/Documents/assembly/input.txt", "r");

    int n, i;
    Node *root = (Node*) malloc(4000 * sizeof(Node)); 

    Node *tmp = root;

    fscanf (fin, "%d", &n);
    tmp->next = NULL;
    tmp->data = n;

    while (fscanf (fin, "%d", &n) == 1)
    {
        tmp->next = tmp+1;
        tmp++;
        tmp->data = n;
        tmp->next = NULL;
    }
    
    printf("Linked List before sorting \n"); 
	printList(root); 

    Node *h = lastNode(root); 

	quickSort(root, h);

    printf("Linked List after sorting \n"); 
	printList(root); 

    return 0; 
} 
