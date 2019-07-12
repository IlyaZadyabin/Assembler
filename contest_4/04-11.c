#include <stdio.h>
#include <malloc.h>

typedef struct Node
{
    int data;
    struct Node *next;
} Node;

int main(void)
{
    FILE *fin;
    fin = fopen("/home/main/Documents/assembly/input.txt", "r");
    int i, N, M, a, b, n, exchange;
    Node **idx_array = (Node** ) malloc((N+1) * sizeof(Node*));
    
   // for(i = 0; i < N; i++)
    //{
   //     idx_array[i] = (Node*)malloc(sizeof(Node));
   // }

    fscanf(fin, "%d", &N);
    fscanf(fin, "%d", &M);

    Node *root = (Node*) malloc(N * sizeof(Node));

    Node *tmp = root;

    tmp->next = NULL;
    tmp->data = 1;

    for (i = 2; i <= N; i++)
    {
        tmp->next = tmp+1;
        tmp++;
        tmp->data = i;
        tmp->next = NULL;
    }

    tmp = root;
    for(i = 1; tmp; i++)
    {
        idx_array[i] = tmp;
        tmp = tmp->next;
    }
  
    for(i = 0; i < M; i++)
    {
        fscanf(fin, "%d", &a);
        fscanf(fin, "%d", &b);
        
        if(a > b)
        {
            exchange = b;
            b = a;
            a = exchange;
        }

        if(root != idx_array[a])
        {
            idx_array[b]->next = root;
            root = idx_array[a];
            if(idx_array[b]->next != 0)
            {
                (idx_array[a-1])->next = idx_array[b+1];
                //idx_array[b+1]->next = NULL;
            }
            else
                idx_array[a-1]->next = NULL;
        }
    }

    tmp = root;
    while(tmp)
    {
        printf("%d ", tmp->data);
        tmp = tmp->next;
    }
    fclose(fin);
}