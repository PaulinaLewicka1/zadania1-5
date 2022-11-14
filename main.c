#include <stdlib.h>
#include <stdio.h>
#include "lib.h"

int main(int argc, char** argv)
{

  int test =3;
  
  node* head = NULL;
  int select = 1;
  
  while(select) {
    printf("Menu\n");
    printf("1 - dodaj element na poczatku listy \n");
    printf("2 - dodaj element na koncu listy \n");
    printf("3 - usun pierwszy element listy \n");
    printf("4 - usun ostatni element listy \n");
    printf("5 - odszukaj zadany element \n");
    printf("6 - dodaj nowy element przed wskazanym \n");
    printf("7 - dodaj nowy element za wskazanym \n");
    printf("8 - usun wskazany element \n");
    printf("9 - wczytaj zawartosc listy z pliku \n");
    printf("10 - zapisz zawartosc listy do pliku \n");
    printf("11 - wyswietl zawartosc listy \n");
    printf("0 - zakoncz dzialanie programu \n");

    printf("Wybierz opcję: ");
    scanf("%d", &select);
  
    switch(select){
      case 1:
        void push(node **head, int val);
        break;
      case 2:
        void pushEnd(node **head, int val);
        break;
      case 3:
        void pop(node **head);
        break;
      case 4:
        void popEnd(node **head);
      case 5:
        node* find(node *head, int val);
      case 6:
        void pushBefore(node **head, node *current, int val);
      case 7:
        void pushAfter(node **head, node *current, int val);
        break;
      case 8:
        void removeNode(node **head, node *current);
        break;
      case 9:
        node* readFromFile(char *fname);
        break;
      case 10:
        int saveToFile(node *head, char *fname);
        break;
      case 11:
      //wyświetl zawartość listy
      case 0:
        //koniec programu
        break;
      default:
          printf("Nie ma takiej opcji w menu!");
          continue;
      }

  }


  return 0;
}