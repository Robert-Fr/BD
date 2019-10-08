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
//on fait la requete permettant d'afficher l'ensemble des cages pour que l'utilisateur choisisse
            Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("SELECT * from LesCages");
            while(resultat.next()) { // recuperation des resultats
              System.out.println("Numero = " + resultat.getString("noCage") + ", Fonction = " + resultat.getString("fonction")+ ", Numero Allee= " + resultat.getString("noAllee"));
	    };
            requete.close();
//l'utilisateur choisit
	System.out.println("choisissez un numero de cage et une fonction :");
	LectureClavier c= new LectureClavier();
	int nocage= c.lireEntier("");
	String fonction= c.lireChaine("");
//verification des contraintes

//on fait la mise a jour
	 Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("update Lescages Set fonction=" + fonction +" 	where noCage =" +nocage);
}
//DEUXIEME requete
Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("SELECT * from LesGardiens");
            while(resultat.next()) { // recuperation des resultats
              System.out.println("Numero cage = " + resultat.getString("noCage") + ", nom Gardien = " + resultat.getString("nomE") );
	    };
            requete.close();
//on demande a l'utilisateur
System.out.println("choisissez un nom d'employé:");
	LectureClavier c= new LectureClavier();
	String nom= c.lireChaine("");
Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("SELECT LesCages.noCage from (LesCages left join Lesgardiens on lesgardiens.noCage = LesCages.noCage) where Lesgardiens.nomE = " + nom);
            while(resultat.next()) { // recuperation des resultats
              System.out.println("Numero = " + resultat.getString("noCage") + ", Fonction = " + resultat.getString("fonction")+ ", Numero Allee= " + resultat.getString("noAllee"));
	    };
            requete.close();
//on demande le numero de la cage ou il va etre retire
System.out.println("choisissez un numero de cage ou le gardien sera retire :");
	LectureClavier c= new LectureClavier();
	nocage= c.lireEntier("");
ResultSet resultat = requete.executeQuery("Delete from Lesgardiens Where (nomE = " + nom +" and noCage = "+ nocage + ")");
requete.close();
//on teste la deuxieme contrainte
Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("SELECT NomA FROM LesAnimaux where noCage ="+nocage );
Statement requete2 = conn.createStatement();
            ResultSet resultat2 = requete2.executeQuery("SELECT NomE FROM Lescages where noCage ="+nocage );
//si la cage est vide et qu'elle a un gardien on fait pas la requete
if(!resultat.next() && resultat2.next()){
return ;
}
//on affiche les cages compatibles avec la fonction du gardien
Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("Select LesCages.noCage From (Lescages left join LesSpecialites on Lescages.fonction = LesSpecialites.fonction_cage) where LesSpecialites.nomE="+ nom);
            while(resultat.next()) { // recuperation des resultats
              System.out.println("Numero cage = " + resultat.getString("noCage") + ", nom Gardien = " + resultat.getString("nomE") );
	    };
            requete.close();
//on choisit le numero de la cage de destination.
System.out.println("choisissez un numero de cage ou le gardien sera affecte:");
	LectureClavier c= new LectureClavier();
	nocage= c.lireEntier("");   
//2ème contrainte
Statement requete = conn.createStatement();
            ResultSet resultat = requete.executeQuery("insert into lesgardiens(noCage,nomE) values ("+nocage+","+nom+")");         


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
