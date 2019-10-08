import java.sql.*;

public class squelette_appli {
	
	static final String CONN_URL = "jdbc:oracle:thin:@im2ag-oracle.e.ujf-grenoble.fr:1521:im2ag";
	
	static final String USER = "tmprobert";
	static final String PASSWD = "v8mRqUXj19";

	static Connection conn; 
	
	
    public static void main(String args[]) {

        try {
        
  	    // Enregistrement du driver Oracle
  	    System.out.print("Loading Oracle driver... "); 
  	    DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());  	    System.out.println("loaded");
  	    
  	    // Etablissement de la connection
  	    System.out.print("Connecting to the database... "); 
 	    conn = DriverManager.getConnection(CONN_URL,USER,PASSWD);
   	    System.out.println("connected");
  	    
  	    // Desactivation de l'autocommit
	  	conn.setAutoCommit(false);
  	    System.out.println("Autocommit disabled");

	    // code metier de la fonctionnalite
            Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("SELECT * from LesCages");
            while(resultat.next()) { // recuperation des resultats
              System.out.println("Numero = " + resultat.getString("noCage") + ", Fonction = " + resultat.getString("fonction")+ ", Numero Allee= " + resultat.getString("noAllee"));
	    };
            requete.close();
	System.out.println("choisissez un numero de cage et une fonction :");
	LectureClavier c= new LectureClavier();
	int nocage= c.lireEntier("");
	String fonction= c.lireChaine("");
	 Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("update Lescages Set fonction=" + fonction +" where noCage =" +nocage);
            


  	    // Liberation des ressources et fermeture de la connexion...
       	// A COMPLETER
 		conn.close(); 
 	    
  	    System.out.println("bye.");
  	    
  	    // traitement d'exception
          } catch (SQLException e) {
              System.err.println("failed");
              System.out.println("Affichage de la pile d'erreur");
  	          e.printStackTrace(System.err);
              System.out.println("Affichage du message d'erreur");
              System.out.println(e.getMessage());
              System.out.println("Affichage du code d'erreur");
  	          System.out.println(e.getErrorCode());	    

          }
     }
	

}
