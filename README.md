# aulaDeJava


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;



public class CategoriaDAO {
	private Connection connection;

	public CategoriaDAO(Connection connection) {
		this.connection = connection;
	}

public List<Categoria> listar() throws SQLException {
	
	List<Categoria> categorias = new ArrayList<Categoria>();
	String sql = "select * from categoria";
	PreparedStatement stmt = connection.prepareStatement(sql);
	ResultSet rs = stmt.executeQuery();
	
	while (rs.next()) {
		Categoria categoria = new Categoria();
		categoria.setIdCategoria(rs.getInt(1));
		categoria.setNome(rs.getString(2));
		categorias.add(categoria);
		
	}
	rs.close();
	stmt.close();
	return categorias;
}
	public List<Categoria> listarComProduto(){
		try {
			Categoria ultima = null;
			List<Categoria> categorias = new ArrayList();
			
			String sql = "SELECT C.idCategoria, C.NOME, P.idProduto, P.NOME, P.DESCRICAO"
			+ "FROM CATEGORIA C"+ "INNER JOIN PRODUTO P ON C.idCategoria = P.idCategoria";  
			
			try(PreparedStatement pstm = connection.prepareStatement(sql)) {
				pstm.execute();
				
				try(ResultSet rst = pstm.getResultSet()){
					
					while(rst.next()) {
						if(ultima == null || !ultima.getNome().equals(rst.getString(2))) {
							Categoria categoria = new Categoria();
							categoria.setIdCategoria(rst.getInt("idCategoria"));
							categoria.setNome(rst.getString("nome"));
							
							categorias.add(categoria);
							ultima = categoria;
						}
						Produto produto = new Produto(rst.getInt(3), rst.getString(4), rst.getString(5));
						ultima.adicionar(produto);
					}
									
				}
				return categorias;
			}
			
			
	}catch(SQLException e) {
		throw new RuntimeException(e);
	}
}

}
