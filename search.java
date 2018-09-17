package glifico.ui;

import glifico.Rest;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import jeeves.core.Dao;
import jeeves.core.Options;
import jeeves.utility.Util;

import org.bson.Document;

public class Search {

	public static Vector<String> doComboListLanguages() throws Exception {
		Vector<String> val = new Vector<String>();
		List<Document> documenti = Rest.getLanguages();
		Iterator<Document> it = documenti.iterator();
		while(it.hasNext()){
			Document doc = (Document) it.next();
			if(doc.getString("ISO3").equalsIgnoreCase("NS")){

			}else{
				val.add( doc.getString("Language") +"|"+ Integer.toString(doc.getInteger("Id")));
			}
		}
		return val;
	}

	public static Vector<String> doComboListSpecializations() throws Exception {
		Vector<String> val = new Vector<String>();
		List<Document> documenti = Utenti.getSpecializationParamList();
		Iterator it = documenti.iterator();
		while(it.hasNext()){
			Document doc = (Document) it.next();
			val.add( doc.getString("Parametro") +"|"+ Integer.toString(doc.getInteger("Id")));
		}
		return val;
	}

	public static List<Document> doSearch(String idLanguageFrom, String idLanguageTo, Boolean isFromMothertongue, Boolean isToMothertongue, String idSpecialization) throws Exception{
		List<Document> ret = null;
		Connection conn = Util.openConnection();
		Options opt = new Options();
		System.out.println(idLanguageFrom);
		if(idLanguageFrom==null || idLanguageFrom.equalsIgnoreCase("")){
			throw new Exception("Please select language from");
		}
		if(idLanguageTo==null || idLanguageTo.equalsIgnoreCase("")){
			throw new Exception("Please select language to");
		}
		System.out.println("isfrom="+isFromMothertongue);
		String motherTongue = null;
		if(isFromMothertongue!=null && isFromMothertongue){
			motherTongue = idLanguageFrom;
			System.out.println("MT="+motherTongue);
		}
		System.out.println("isto="+isToMothertongue);
		if(isToMothertongue!=null && isToMothertongue){
			motherTongue = idLanguageTo;
			System.out.println("MT="+motherTongue);
		}

		try {
			ret = Dao.getSQLFasciaPrezziToDocument(conn, opt, idLanguageFrom, idLanguageTo, motherTongue, idSpecialization);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		} finally {
			conn.setAutoCommit(true);
			if (null != conn) {
				Util.closeConnection(conn);
			}
		}
		//System.out.println(ret.toString());
		return ret;
	}

	public static String getEdu(String idUtente) throws Exception{
		String ret = "";
		List<Document> edus = Utenti.getEducationsByIdUtente(idUtente, true);
		int i = 1;
		ret += "<ul style=\"font-size:10px;width:220px;\" class=\"list-group text-left\">";
		for(Document edu:edus){

			ret += "<li class=\"list-group-item\">";
			ret += "<span class=\"badge\">"+Integer.toString(i)+"</span>";
			ret += edu.getString("Institute");
			ret += " - ";
			ret += edu.getString("Field");
			ret += "</li>";
			i++;
		}
		ret += "</ul>";
		return ret;
	}
	// Provo a prendere i dati del Social Rating
	public static String getRating(String idUtente) throws Exception{
		try {
			String ret = "";
			List<Document> edus = Utenti.getRatingByIdUtente(idUtente, true);
			int i = 1;
			ret += "<ul style=\"font-size:10px;width:220px;\" class=\"list-group text-left\">";
			Document edu = edus.get(0);

				ret += "<li class=\"list-group-item\">";
				//ret += "<span class=\"badge\">"+Integer.toString(i)+"</span>";
				ret += "<b>Media Votazioni: </b> " + edu.get("MediaVotazioni").toString();
				ret += "</li>";
				ret += "<li class=\"list-group-item\">";
				ret += "<b> Numero Votazioni:</b> " +edu.get("NumeroVotazioni").toString();
				ret += "</li>";
				i++;
			ret += "</ul>";
			return ret;
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	public static String getSpec(String idUtente) throws Exception{
		String ret = "";
		List<Document> edus = Utenti.getSpecializationsByIdUtente(idUtente, true);
		int i = 1;
		ret += "<ul style=\"font-size:10px;width:220px;\" class=\"list-group text-left\">";
		for(Document edu:edus){

			ret += "<li class=\"list-group-item\">";
			ret += "<span class=\"badge\">"+Integer.toString(i)+"</span>";
			ret += edu.getString("Certification");
			ret += " - ";
			ret += edu.getString("SpecLevel");
			ret += "</li>";
			i++;
		}
		ret += "</li></ul>";
		return ret;
	}
	public static String getTest(String idUtente) throws Exception{
		String ret = "";
		List<Document> edus = Utenti.getSpecializationsByIdUtente(idUtente, true);
		int i = 1;
		ret += "<ul style=\"font-size:10px;width:220px;\" class=\"list-group text-left\">";
		for(Document edu:edus){

			ret += "<li class=\"list-group-item\">";
			ret += "<span class=\"badge\">"+Integer.toString(i)+"</span>";
			ret += edu.getString("Certification");
			ret += " - ";
			ret += edu.getString("SpecLevel");
			ret += "</li>";
			i++;
		}
		ret += "</li></ul>";
		return ret;
	}
}
