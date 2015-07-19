//
//  main.c
//  创建单链表
//
//  Created by ethan on 15/7/19.
//  Copyright (c) 2015年 ethan. All rights reserved.
//

#include <stdio.h>
 #include <stdlib.h>


struct ListNode {
    int val;
    struct ListNode *next;
};

typedef struct ListNode *PtrToNode;
typedef PtrToNode Node;
typedef PtrToNode List;

typedef int bool;


#define true        1
#define false       0


//method    此单链表  不使用表头


List makeEmpty(List l);
bool isEmpty(List l);
//只查找第一个出现
bool isLast(int p, List l);
//只找第一个
Node find(int p, List l);
//删除所有等于P的
List delete(int p, List l);
Node findPrevious(int p, List l);
List insert(int p, List l);
void printList(List l);


List makeEmpty(List l) {
    while (l) {
        Node tmp = l;
        l = l->next;
        free(tmp);
    }
    
    return NULL;
}

bool isEmpty(List l) {
    if (l == NULL) {
        return true;
    }
    
    return false;
}


bool isLast(int p, List l) {
    while (l) {
        if (l->val == p && l->next == NULL) {
            return true;
        } else {
            if (l->next == NULL) {
                return false;
            } else {
                l = l->next;
            }
        }
    }
    
    return false;
}

Node find(int p, List l) {
    while (l) {
        if (l->val == p) {
            return l;
        }
        
        l = l->next;
    }
    
    return NULL;
}

List delete(int p, List l) {
    Node result;
    if (isEmpty(l)) {
        return NULL;
    }
    
    Node head = l;
    while ((result = find(p, l))) {
        if (result->next == NULL) {  //最后一个节点
            Node previous = findPrevious(p, l);
            if (previous) {
                previous->next = NULL;
                free(result);
            } else {
                //只有唯一一个节点
                free(result);
                return NULL;
            }
            
            break;
        } else {
            Node tmp = result->next;
            result->val = result->next->val;
            result->next = result->next->next;
            free(tmp);
            l = result;
        }
    }
    
    return head;
}



Node findPrevious(int p, List l) {
    Node previsous;
    while (l) {
        previsous = l;
        if (l->next && l->next->val == p) {
            return previsous;
        }
        
        l = l->next;
    }
    
    return NULL;
}



void printList(List l) {
    while (l) {
        printf("value : %d pointer : %p\n", l->val, l);
        l = l->next;
    }
}

List insert(int p, List l) {
   
    if (l == NULL) {   //链表为空 新建
        Node newNode = malloc(sizeof(struct ListNode));
        newNode->val = p;
        newNode->next = NULL;
        
        return newNode;
    }
    
    List head = l;
    while (l) {
        if (l->next == NULL) {
            Node newNode = malloc(sizeof(struct ListNode));
            newNode->val = p;
            newNode->next = NULL;
            l->next = newNode;
            
            return head;
        }
        
        l = l->next;
    }
    return head;
}


int main(int argc, const char * argv[]) {
    // insert code here...
    printf("Hello, World!\n");
    List l = NULL;
    
    l = insert(10, l);
    l = insert(7, l);
    l = insert(3, l);
    l = insert(7, l);
    l = insert(5, l);
    l = insert(1, l);
    l = insert(3, l);
    l = insert(8, l);
    l = insert(1, l);
    l = insert(2, l);
    
    
    printList(l);
    printf("是否为空 : %d\n", isEmpty(l));
    printf("2是否为最后一个 : %d\n", isLast(2, l));
    printf("1是否为最后一个 : %d\n", isLast(1, l));
    
    printf("查找值为 1: %p\n", find(1, l));
    printf("查找值为 10: %p\n", find(10, l));
    printf("查找值为 2: %p\n", find(2, l));
    
    printf("查找值为 1 之前: %p\n", findPrevious(1, l));
    printf("查找值为 10 之前: %p\n", findPrevious(10, l));
    printf("查找值为 2 之前: %p\n", findPrevious(2, l));
    
    l = delete(10, l);
    printf("*****删除节点10之后\n");
    printList(l);
    
    l = delete(2, l);
    printf("*****删除节点2之后\n");
    printList(l);
    
    l = delete(1, l);
    printf("*****删除节点1之后\n");
    printList(l);
    
    l = delete(3, l);
    printf("*****删除节点3之后\n");
    printList(l);
    
    l = makeEmpty(l);
    
    printf("销毁链表之后\n");
    printList(l);
    
    
    
    /**
     bool isEmpty(List l);
     bool isLast(List l);
     //只找第一个
     Node find(int p, List l);
     //删除所有等于P的
     void delete(int p, List l);
     Node findPrevious(int p, List l);
     List insert(int p, List l);
     void printList(List l);
     **/
    
    
    return 0;
}
