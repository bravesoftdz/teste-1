#include <conio.h>
#include <stdio.h>

main()
{
  float nota1,nota2,calc_media;
  printf("\nDigite o primeiro numero ");
  scanf("%f",&nota1);
  printf("\nDigite o segundo numero ");
  scanf("%f",&nota2); 
  calc_media = (nota1 + nota2) / 2;      
  printf("\nA media = %f",calc_media);
  printf("\n");
  printf("\n...............fim................");
  
  getch();   
}
