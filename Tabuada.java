/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package tabuada;

/**
 *
 * @author Cilandro Bes
 */
import javax.swing.JOptionPane;
public class Tabuada {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        int num;
        int contador = 1;
        String mensagem = "";
      num = Integer.parseInt(JOptionPane.showInputDialog("Digite o numero que deseja multiplicar."));
        if (num <= 0)
         {
            JOptionPane.showMessageDialog(null,"O numero digitado é menor que 0 :");

         }

        else
         {
//            JOptionPane.showMessageDialog(null,"Você digitou o numero "+num +" que é maior que 0 portanto: \n1 x "+num+ " = "+num * 1 +
//            "\n2 x "+num+ " = "+num * 2 + "\n3 x "+num+ " = "+num * 3 + "\n4 x "+num+ " = "+num * 4 +
//            "\n5 x "+num+ " = "+num * 5 + "\n6 x "+num+ " = "+num * 6 + "\n7 x "+num+ " = "+num * 7 +
//            "\n8 x "+num+ " = "+num * 8 + "\n9 x "+num+ " = "+num * 9 + "\n10 x "+num+ " = "+num * 10);
             // Aqui podemos utilizar o WHILE para indicar a tabuada, dessa forma:
             // A primeira vez que o programa entra aqui, ele tem o valor 1, que foi colocado lá em cima, depois do int num.
             while (contador<10)
             {
                 // O while vai executar os comandos que estão entre as chaves até o contador deixar de ser menor que dez
                 
                 // Esse comando diz o seguinte a mensagem recebe ela mesmo mais a próxima linha da multiplicação.
                 // Na primeira vez ela tá vazia. Na segunda vez que vai rodar, 
                 // vai ter a primeira linha MAIS a segunda linha que vai ser colocada
                 // Na terceira vez, terá a primeira e a segunda linha e MAIS a terceira, assim por diante 
                 mensagem = mensagem + num+" multiplicado por "+contador+" é igual a "+(num*contador)+"\n";
                 // Tu viu que eu coloquei parênteses aonde ele calcula, não é necessário, mas é interessante porque
                 // funciona como na matemática, a linguagem primeiro vai fazer o que está dentro do parênteses e, 
                 // depois, faz o que está fora. ;) fica como dica

                 
                 // 
                 // Porque contador mais 1? Para que ele chegue até o 10, senão o programa TRAVA
                 // 
                 contador = contador + 1;
                 
                 // Recapitulando o while, tudo o que está identado dentro do while (com uns espaços a mais no começo
                 // será repetido, ENQUANTO o que estiver dentro for true, ou seja, se contador for menor que 10, então,
                 // executa o que está dentro, aí ele volta e verifica de novo, se contador for menor que 10, então vai de 
                 // novo, até que contador deixe de ser 10, por isso é importante esse contador+1 aí em cima.
             }
             // Depois de a gente montar a string, mostramos ela daí.
             JOptionPane.showMessageDialog(null,"Você digitou o numero "+num +" que é maior que 0 portanto: \n"+mensagem);
         }
    }
}
