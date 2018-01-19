import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Conexao {
	//Banco de dados utilizado neste exemplo foi LIVROS
    public static void main(String args[]) throws ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/livros";
        try {
            Connection con = (Connection) DriverManager.getConnection(url, "root", "");
	        //Verifica se a conexão esta correta, após verificar comente esta linha.
            System.out.println("Con: "+ con);
			//Cria o objeto
            Statement statement = (Statement) con.createStatement();
			//Codigo para inserir registros na tabela,tambem pode-se excluir ou alterar dados,após verificar comente esta linha.
            statement.executeUpdate("insert into livro(NomeLivro,NomeAutor,NomeEditora,Nota,Comentarios)values('Teste6','Teste6','Teste6',4,'Teste66666666666')");
            //Procura registros na tabela,após verificar comente esta linha.
			ResultSet rs = statement.executeQuery("Select * from livro");
            if (rs.first()) {
                do {
                    System.out.println("Nome: " + rs.getString("NomeLivro"));
                } while (rs.next());
            }		
          
        } catch (SQLException ex) {
            Logger.getLogger(Conexao.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}