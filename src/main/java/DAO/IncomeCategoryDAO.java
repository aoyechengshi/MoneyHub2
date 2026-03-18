package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entity.Income;

public class IncomeCategoryDAO {

	private Connection con;

	// DB接続
	public IncomeCategoryDAO(Connection connection) {
		this.con = connection;
	}

	//収入名検索メソッド
	public ArrayList<Income> getIncomeCategory(int userId) throws SQLException {
		String sql = "SELECT categoryincome_id, category FROM incometype WHERE user_id = ?";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<Income> List = new ArrayList<>();
		Income income = null;

		try {
			// PreparedStatement
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, userId);
			rs = stmt.executeQuery();

			while (rs.next()) {
				income = new Income();
				income.setIncomeCategoryId(rs.getInt("categoryincome_id"));
				income.setCategory(rs.getString("category"));
				List.add(income);
			}
		} finally {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}

		}
		return List;
	}

	//収入カテゴリ追加
	public boolean insertIncomeCategory(int userId, String category) throws SQLException {
		String sql = "INSERT INTO incometype (user_id, category) VALUES (?,?)";
		PreparedStatement stmt = null;
		boolean result = false;

		try {
			// PreparedStatement
			stmt = con.prepareStatement(sql);
			stmt.setInt(1, userId);
			stmt.setString(2, category);
			int rows = stmt.executeUpdate();

			if (rows > 0) {
				result = true;
			}

		} finally {

			if (stmt != null) {
				stmt.close();
			}

		}
		return result;
	}

	//収入カテゴリ削除（関連する income を先に削除してから incometype を削除）
	public boolean deleteIncomeCategory(int userId, String categoryId) throws SQLException {
		PreparedStatement stmt = null;

		try {
			// 関連する income レコードを先に削除
			stmt = con.prepareStatement("DELETE FROM income WHERE categoryincome_id = ? AND user_id = ?");
			stmt.setString(1, categoryId);
			stmt.setInt(2, userId);
			stmt.executeUpdate();
			stmt.close();

			// カテゴリ本体を削除
			stmt = con.prepareStatement("DELETE FROM incometype WHERE user_id = ? AND categoryincome_id = ?");
			stmt.setInt(1, userId);
			stmt.setString(2, categoryId);
			int rows = stmt.executeUpdate();

			return rows > 0;

		} finally {
			if (stmt != null) {
				stmt.close();
			}
		}
	}
}
